using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using SportWebStore.Models;
using System.Data;

namespace SportWebStore.Services
{
    public class BrandService: BaseService,IBrandService
    {
        private readonly IDbConnection _connection;
        private static Brand ToBrand(IDataReader reader)
        {
            return new Brand(
              (string)reader["brand_name"],
              (int)reader["brand_tagid"]

                );

        }

        public BrandService(IDbConnection connection)
        {
            _connection = connection;
        }

        public List<Brand> GetAllBrands()
        {
            List<Brand> brands = new List<Brand>();
            using var command = _connection.CreateCommand();
            command.CommandText = "Select * From brand_tag";
            using var reader = command.ExecuteReader();
            while (reader.Read())
            {
                brands.Add(ToBrand(reader));
            }
            return brands;
        }

        public Brand GetBrandToAnItem(int itemID)
        {
            using var command = _connection.CreateCommand();
            command.CommandText = "SELECT bt.brand_tagid,bt.brand_name FROM brand_tag AS bt JOIN brand_item_tag AS bit ON(bt.brand_tagid = bit.brand_tagid) WHERE bit.itemid = @itemid";
            var param = command.CreateParameter();
            param.ParameterName = "itemid";
            param.Value = itemID;

            command.Parameters.Add(param);
            using var reader = command.ExecuteReader();

            reader.Read();
            return ToBrand(reader);
        }
    }
}
