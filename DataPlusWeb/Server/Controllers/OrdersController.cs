using DataPlusWeb.Client.Pages.Orders;
using Microsoft.AspNetCore.Mvc;

namespace DataPlusWeb.Server.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class OrdersController : ControllerBase
    {
        [HttpGet]
        public IEnumerable<OrderViewModel> Get(string orderCategoryCode)
        {
            var orders = new List<OrderViewModel>();
            for (int i = 0; i < 20; i++)
            {
                orders.Add(new()
                {
                    OrderId = 852141 + i,
                    OrderGroup = "852142-1",
                    Patient = "Casey Crosby",
                    PatientDOB = DateTime.Now,
                    Doctor = "INGE LUECHINGER",
                    FacilityAddress = "",
                    FacilityPhone = "1000000014",
                    CaseId = "",
                    Client = "",
                    ClientId = 1710,
                    Type = "Medical Records",
                    OrderDate = DateTime.Now,
                    DaysOld = 1,
                    OrderStage = "New",
                    Team = "Team 1",

                    Category = (i % 4) switch { 0 => "APS", 1 => "Audit", 2 => "Claims", 3 => "Other", _ => null },
                    CategoryCode = (i % 4) switch { 0 => "APS", 1 => "Audit", 2 => "Claims", 3 => "Other", _ => null }
                });
            }

            return orders.Where(o =>
                (orderCategoryCode == null || o.CategoryCode == orderCategoryCode)
            );

        }
    }
}