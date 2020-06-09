using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using SportWebStore.Models;
using System.Data;

namespace SportWebStore.Services
{
    public class ItemTypeService : BaseService,IItemTypeService
    {
        private readonly IDbConnection _connection;
        private static ItemType ToItemType(IDataReader reader)
        {
            return new ItemType(
              (string)reader["types_name"],
              (int)reader["type_tagid"]

                );

        }

        public ItemTypeService(IDbConnection connection)
        {
            _connection = connection;
        }

        public List<ItemType> GetAllItemType()
        {
            List<ItemType> itemTypes = new List<ItemType>();
            using var command = _connection.CreateCommand();
            command.CommandText = "Select * From type_tag";
            using var reader = command.ExecuteReader();
            while (reader.Read())
            {
                itemTypes.Add(ToItemType(reader));
            }
            return itemTypes;
        }
    }
}
