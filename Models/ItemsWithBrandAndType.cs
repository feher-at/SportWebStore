using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SportWebStore.Models
{
    public class ItemsWithBrandAndType
    {
        public List<Item> Items { get; set; }
        public List<Brand> Brands { get; set; }
        public List<ItemType> ItemTypes { get; set; }
        public List<ItemMainType> MainTypes { get; set; }
        

        public ItemsWithBrandAndType(List<Item> items, List<Brand> brands, List<ItemType> itemTypes, List<ItemMainType> mainTypes)
        {
            Items = items;
            Brands = brands;
            ItemTypes = itemTypes;
            MainTypes = mainTypes;
        }
    }
}
