using System.ComponentModel.DataAnnotations;

namespace DataPlusWeb.Client.Pages.Orders
{
    public class OrderViewModel
    {
        public int OrderId { get; set; }

        public string OrderGroup { get; set; }

        public string Patient { get; set; }

        public DateTime PatientDOB { get; set; }

        public string Category { get; set; }

        [Display(AutoGenerateField = false)]
        public string CategoryCode { get; set; }

        public string Doctor { get; set; }

        public string FacilityAddress { get; set; }

        public string FacilityPhone { get; set; }

        public string CaseId { get; set; }

        public string Client { get; set; }

        public int ClientId { get; set; }

        public string Type { get; set; }

        public DateTime OrderDate { get; set; }

        public int DaysOld { get; set; }

        public string OrderStage { get; set; }

        public string Team { get; set; }
    }
}
