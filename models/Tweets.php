<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "tweets".
 *
 * @property integer $id
 * @property integer $user_id
 * @property string $place
 * @property string $tweets
 * @property integer $created_at
 * @property integer $updated_at
 *
 * @property User $user
 */
class Tweets extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'tweets';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['user_id', 'created_at'], 'integer'],
            [['tweets'], 'string'],
            [['place'], 'string', 'max' => 255]
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'user_id' => 'User ID',
            'place' => 'Place',
            'tweets' => 'Tweets',
            'created_at' => 'Created At'
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getUser()
    {
        return $this->hasOne(User::className(), ['id' => 'user_id']);
    }
    
    public static function isTweetsByUser($user_id, $place){
        $tweets = static::findOne(['user_id' => $user_id, 'place' => $place]);
        if($tweets)
            return true;
        return false;
    }
}
