using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using SportWebStore.Models;

namespace SportWebStore.Services
{
    public interface IItemMainTypeService
    {
        List<ItemMainType> GetAllMainType();

    }
}
