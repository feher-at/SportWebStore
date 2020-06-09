using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using SportWebStore.Models;
using System.Data;

namespace SportWebStore.Services
{
    public class OpinionService: BaseService,IOpinionService
    {
        private readonly IDbConnection _connection;
        private static OpinionsAboutItem ToOpinion(IDataReader reader)
        {
            return new OpinionsAboutItem(
              (int)reader["opinionid"],
              (string)reader["username"],
              (string)reader["opinion"],
              (int)reader["the_user_rating"],
              (DateTime)reader["post_time"],
              (int)reader["itemid"]

                );

        }

        public OpinionService(IDbConnection connection)
        {
            _connection = connection;
        }

        public List<OpinionsAboutItem> GetAllOpinionsToAnItem(int itemID)
        {
            List<OpinionsAboutItem> opinions = new List<OpinionsAboutItem>();
            using var command = _connection.CreateCommand();
            var param = command.CreateParameter();
            param.ParameterName = "chosenItemID";
            param.Value = itemID;
            command.Parameters.Add(param);
            command.CommandText = "SELECT o.opinionid,users.username,o.opinion,o.the_user_rating,o.post_time,o.itemid FROM opinion AS o JOIN items ON (o.itemid = items.itemid) JOIN users ON(o.userid = users.userid) WHERE items.itemid = @chosenItemID"; 
            using var reader = command.ExecuteReader();
            
            
            while (reader.Read())
            {
                opinions.Add(ToOpinion(reader));
            }
            return opinions;
        }

        public void InsertOpinion(int userID, string opinion,int userRating,DateTime postTime,int itemID)
        {
            using var command = _connection.CreateCommand();

            var userIdParam = command.CreateParameter();
            userIdParam.ParameterName = "userid";
            userIdParam.Value = userID;

            var opinionParam = command.CreateParameter();
            opinionParam.ParameterName = "opinion";
            opinionParam.Value = opinion;

            var userRatingParam = command.CreateParameter();
            userRatingParam.ParameterName = "userRating";
            userRatingParam.Value = userRating;

            var postTimeParam = command.CreateParameter();
            postTimeParam.ParameterName = "postTime";
            postTimeParam.Value = postTime;

            var itemIdParam = command.CreateParameter();
            itemIdParam.ParameterName = "itemid";
            itemIdParam.Value = itemID;

            command.CommandText = $"INSERT INTO opinion(userID,opinion,the_user_rating,post_time,itemID) VALUES (@userid, @opinion, @userRating, @postTime, @itemid)";

            command.Parameters.Add(userIdParam);
            command.Parameters.Add(opinionParam);
            command.Parameters.Add(userRatingParam);
            command.Parameters.Add(postTimeParam);
            command.Parameters.Add(itemIdParam);
            HandleExecuteNonQuery(command);
        }

    }
}
