using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SportWebStore.Models
{
    public class Brand
    {
        public string BrandName { get; set; }

        public int BrandID { get; set; }


        public Brand(string brandName, int brandID )
        {
            BrandName = brandName;
            BrandID = brandID;
        }

    }
}
