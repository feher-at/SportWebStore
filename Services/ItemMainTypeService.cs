using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using SportWebStore.Models;
using System.Data;

namespace SportWebStore.Services
{
    public class ItemMainTypeService: BaseService,IItemMainTypeService
    {
        private readonly IDbConnection _connection;
        private static ItemMainType ToMainType(IDataReader reader)
        {
            return new ItemMainType(
              (int)reader["main_tagid"],
              (string)reader["main_tag_name"]

                );

        }

        public ItemMainTypeService(IDbConnection connection)
        {
            _connection = connection;
        }


        public List<ItemMainType> GetAllMainType()
        {
            List<ItemMainType> mainTypes = new List<ItemMainType>();
            using var command = _connection.CreateCommand();
            command.CommandText = "Select * From main_tag";
            using var reader = command.ExecuteReader();
            while (reader.Read())
            {
                mainTypes.Add(ToMainType(reader));
            }
            return mainTypes;
        }
    }
}
