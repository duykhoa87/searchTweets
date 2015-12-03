<?php

namespace app\controllers;

use Yii;
use app\models\LoginForm;
use app\models\ContactForm;
use yii\filters\ContentNegotiator;
use yii\web\Response;
use yii\filters\AccessControl;
use yii\rest\Controller;
use yii\filters\auth\HttpBearerAuth;
use Abraham\TwitterOAuth\TwitterOAuth;
use app\models\Tweets;

/**
 * Site controller
 */
class ApiController extends Controller {

    const SEARCH_RADIUS = '50km';
    const CACHE_TIME = 3600;

    /**
     * @inheritdoc
     */
    public function behaviors() {
        $behaviors = parent::behaviors();
        $behaviors['authenticator'] = [
            'class' => HttpBearerAuth::className(),
            'only' => ['dashboard', 'tweets'],
        ];
        $behaviors['contentNegotiator'] = [
            'class' => ContentNegotiator::className(),
            'formats' => [
                'application/json' => Response::FORMAT_JSON,
            ],
        ];
        $behaviors['access'] = [
            'class' => AccessControl::className(),
            'only' => ['dashboard'],
            'rules' => [
                [
                    'actions' => ['dashboard'],
                    'allow' => true,
                    'roles' => ['@'],
                ],
            ],
        ];
        return $behaviors;
    }

    public function actionLogin() {
        $model = new LoginForm();

        if ($model->load(Yii::$app->getRequest()->getBodyParams(), '') && $model->login()) {
            $response = [
                'access_token' => Yii::$app->user->identity->getAuthKey(),
            ];
            return $response;
        } else {
            $model->validate();
            return $model;
        }
    }

    public function actionDashboard() {

        $response = [
            'username' => Yii::$app->user->identity->username,
            'access_token' => Yii::$app->user->identity->getAuthKey(),
        ];

        return $response;
    }

    public function actionTweets() {
        $postData = Yii::$app->getRequest()->getBodyParams();

        if (isset($postData['latitude']) && $postData['latitude'] && isset($postData['longitude']) && $postData['longitude']) {
            $data = Yii::$app->cache->get($postData['city']);
            if ($data === false) {
                // $data is expired or is not found in the cache
                $geocode = $postData['latitude'] . ',' . $postData['longitude'] . ',' . self::SEARCH_RADIUS;
                $connection = new TwitterOAuth('wT8o4IrBGCCNcnHxZfobEvHVV', 'eG3GQ7nqMXzO14IK7whGd1SyQmWqrKKRfgJJXmeqp910ryA3NV', '2376724225-0m1tu3Q8ru20mTyA0zjxGFKxRBEQkBTaTCAszQl', 'FEuuyd15giBingpwBgpIlQ0T419cUKcAA4kPJF6QLmiNb');
                $tweets = $connection->get("search/tweets", array("geocode" => $geocode));
                $result = [];
                foreach ($tweets->statuses as $tweet) {
                    //check tweet with geo exist
                    if (isset($tweet->geo) && is_array($tweet->geo->coordinates) && count($tweet->geo->coordinates) > 0) {
                        $result[] = array(
                            'desc' => $tweet->text,
                            'avatar' => $tweet->user->profile_image_url,
                            'created_at' => $tweet->created_at,
                            'lat' => $tweet->geo->coordinates[0],
                            'long' => $tweet->geo->coordinates[1]
                        );
                    }
                }
                $this->insertTweets($postData['city'], $result);
                Yii::$app->cache->set($postData['city'], $result, self::CACHE_TIME);
                return ['success' => true, 'result' => $result];
            }  else {
                return ['success' => true, 'result' => $data];
            }
        }
        return ['success' => false, 'result' => []];
    }
    
    private function insertTweets($city, $tweets){

        //check user with city exist in db
        if(!Tweets::isTweetsByUser(Yii::$app->user->identity->id, $city)){
            $model = new Tweets();
            $model->user_id = Yii::$app->user->identity->id;
            $model->place = $city;
            $model->tweets = json_encode($tweets);
            $model->insert();
        }
    }

}
