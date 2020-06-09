using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SportWebStore.Models
{
    public class ItemWithBrand
    {
        public Item Item { get; set; }
        public Brand Brand { get; set; }

        public ItemWithBrand(Item item,Brand brand)
        {
            Item = item;
            Brand = brand;
        }
    }
}
