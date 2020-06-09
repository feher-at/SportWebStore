using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using SportWebStore.Models;

namespace SportWebStore.Services
{
    public interface IItemTypeService
    {
        List<ItemType> GetAllItemType();
    }
}
