using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using SportWebStore.Models;
using System.Data;

namespace SportWebStore.Services
{
    public class ItemService: BaseService,IItemService
    {
        private readonly IDbConnection _connection;
        private static Item ToItem(IDataReader reader)
        {
            return new Item(
                (int)reader["itemid"],
                (string)reader["item_source"],
                (int)reader["item_price"],
                (string)reader["item_description"],
                (string)reader["item_type"],
                (string)reader["item_colour"],
                Convert.ToSingle(reader["rating"])

                );
            
        }

        public ItemService(IDbConnection connection)
        {
            _connection = connection;
        }

        public List<Item> GetAll()
        {
            List<Item> items = new List<Item>();
            using var command = _connection.CreateCommand();
            command.CommandText = "Select * From items";
            using var reader = command.ExecuteReader();
            while (reader.Read())
            {
                items.Add(ToItem(reader));
            }
            return items;
        }

        public List<Item> GetBestFiveRating()
        {
            List<Item> items = new List<Item>();
            using var command = _connection.CreateCommand();
            command.CommandText = "SELECT * FROM items ORDER BY rating desc limit 5";

            using var reader = command.ExecuteReader();

            while (reader.Read())
            {
                items.Add(ToItem(reader));
            }

            return items;
        }
        public Item GetOne(int itemID)
        {
            using var command = _connection.CreateCommand();
            command.CommandText = "Select * from items WHERE itemid = @itemid";
            var param = command.CreateParameter();
            param.ParameterName = "itemid";
            param.Value = itemID;

            command.Parameters.Add(param);
            using var reader = command.ExecuteReader();

            reader.Read();
            return ToItem(reader);
        }

        public List<Item> GetSearchResult(string[] MainTag)
        {
            List<Item> items = new List<Item>();
            MainTag = MainTag[0].Split(',');
            using var command = _connection.CreateCommand();

            if (Convert.ToInt32(MainTag[0]) == 0 && Convert.ToInt32(MainTag[1]) == 0 && Convert.ToInt32(MainTag[2]) == 0)
            {
                command.CommandText = "SELECT * FROM items";
            }

            else if (Convert.ToInt32(MainTag[0]) == 0 && Convert.ToInt32(MainTag[1]) == 0)
            {
                command.CommandText = "SELECT i.itemid,i.item_source,i.item_price,i.item_description,i.item_type,i.item_colour,i.rating  FROM items AS i JOIN type_item_tag AS ti ON(i.itemid = ti.itemid) WHERE ti.type_tagid = @itemType";
            }
            else if (Convert.ToInt32(MainTag[0]) == 0 && Convert.ToInt32(MainTag[2]) == 0)
            {
                command.CommandText = "SELECT i.itemid,i.item_source,i.item_price,i.item_description,i.item_type,i.item_colour,i.rating  FROM items AS i JOIN brand_item_tag AS bt ON(i.itemid = bt.itemid) WHERE bt.brand_tagid = @brand";
            }
            else if (Convert.ToInt32(MainTag[1]) == 0 && Convert.ToInt32(MainTag[2]) == 0)
            {
                command.CommandText = "SELECT i.itemid,i.item_source,i.item_price,i.item_description,i.item_type,i.item_colour,i.rating  FROM items AS i JOIN item_main_tag AS im ON(i.itemid = im.itemid) WHERE im.main_tagid = @maintag";
            }

            else if (Convert.ToInt32(MainTag[0]) == 0)
            {
                command.CommandText = "SELECT i.itemid,i.item_source,i.item_price,i.item_description,i.item_type,i.item_colour,i.rating FROM items AS i JOIN brand_item_tag AS bt ON(i.itemid = bt.itemid) JOIN type_item_tag AS ti ON(i.itemid = ti.itemid) WHERE bt.brand_tagid = @brand " +
                                      "AND ti.type_tagid = @itemType";
               
            }
            else if (Convert.ToInt32(MainTag[1]) == 0)
            {
                command.CommandText = "SELECT i.itemid,i.item_source,i.item_price,i.item_description,i.item_type,i.item_colour,i.rating FROM items AS i JOIN item_main_tag AS im ON(i.itemid = im.itemid) JOIN type_item_tag AS ti ON(i.itemid = ti.itemid) WHERE im.main_tagid = @maintag " +
                                      "AND ti.type_tagid = @itemType";

            }

            else if(Convert.ToInt32(MainTag[2]) == 0)
            {
                command.CommandText = "SELECT i.itemid,i.item_source,i.item_price,i.item_description,i.item_type,i.item_colour,i.rating FROM items AS i JOIN item_main_tag AS im ON(i.itemid = im.itemid) JOIN brand_item_tag AS bt ON(i.itemid = bt.itemid) WHERE im.main_tagid = @maintag " +
                                      "AND bt.brand_tagid = @brand";
                
            }

            else if(Convert.ToInt32(MainTag[0]) != 0 && Convert.ToInt32(MainTag[1]) != 0 && Convert.ToInt32(MainTag[2]) != 0)
            {
                command.CommandText= "SELECT i.itemid,i.item_source,i.item_price,i.item_description,i.item_type,i.item_colour,i.rating FROM items AS i JOIN item_main_tag AS im ON(i.itemid = im.itemid)" +
                                     " JOIN brand_item_tag AS bt ON(i.itemid = bt.itemid) JOIN type_item_tag AS ti ON(i.itemid = ti.itemid) WHERE im.main_tagid = @maintag AND bt.brand_tagid = @brand AND ti.type_tagid = @itemType";
                
            }

            var MainTypeParam = command.CreateParameter();
            MainTypeParam.ParameterName = "maintag";
            MainTypeParam.Value = Convert.ToInt32(MainTag[0]);
            command.Parameters.Add(MainTypeParam);

            var BrandParam = command.CreateParameter();
            BrandParam.ParameterName = "brand";
            BrandParam.Value = Convert.ToInt32(MainTag[1]);
            command.Parameters.Add(BrandParam);

            var ItemTypeParam = command.CreateParameter();
            ItemTypeParam.ParameterName = "itemType";
            ItemTypeParam.Value = Convert.ToInt32(MainTag[2]);
            command.Parameters.Add(ItemTypeParam);

            

            using var reader = command.ExecuteReader();
            while (reader.Read())
            {
                items.Add(ToItem(reader));
            }

            return items;
        }

        public void UpdateItemRating(int itemID,float itemRating)
        {
            

            using var command = _connection.CreateCommand();

            var itemIDParam = command.CreateParameter();
            itemIDParam.ParameterName = "itemid";
            itemIDParam.Value = itemID;

            var itemRatingParam = command.CreateParameter();
            itemRatingParam.ParameterName = "itemrating";
            itemRatingParam.Value = itemRating;

            command.CommandText = "SELECT update_item_rating(@itemid, @itemrating)";
            command.Parameters.Add(itemIDParam);
            command.Parameters.Add(itemRatingParam);
          
            HandleExecuteNonQuery(command);
        }

    }
}
