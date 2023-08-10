using DataPlusWeb.Client.Models;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Net.Http.Headers;
using System.Net.Quic;

namespace DataPlusWeb.Client.Pages.Orders
{
    public class OrderDetailsViewModel
    {
        public int OrderId { get; set; }

        public OrderPatientDetailsViewModel Patient { get; set; } = new();

        public OrderClientDetailsViewModel Client { get; set; } = new();

        public OrderServicesDetailsViewModel Services { get; set; } = new();

        public OrderDoctorDetailsViewModel Doctor { get; set; } = new();

        public OrderDocumentsDetailsViewModel Documents { get; set; } = new();

        public OrderConfirmationDetailsViewModel Confirmation { get; set; } = new();
    }

    public class OrderPatientDetailsViewModel
    {
        [Required]
        public string FirstName { get; set; }

        [Required]
        public string LastName { get; set; }

        public string AKA { get; set; }

        [Required]
        public DateTime? DOB { get; set; } = DateTime.Now.AddYears(-37);

        public string SSN { get; set; }

        public string CaseId { get; set; }

        public string Policy { get; set; }

        public string PatientMRId { get; set; }

        public Address Address { get; set; } = new();
    }

    public class OrderClientDetailsViewModel
    {
        public int ClientId { get; set; }

        public string ClientName { get; set; }

        public int OrderCategoryId { get; set; }

        public int RequesterId { get; set; }

        public AgentDetailsViewModel AgentDetails { get; set; } = new();
    }

    public class AgentDetailsViewModel
    {
        public int BrokerId { get; set; }

        public int AgencyId { get; set; }

        public string AgentName { get; set; }

        public string AgentPhone{ get; set; }

        public string AgentEmail { get; set; }

        public string AgentContact { get; set; }
    }

    public class OrderServicesDetailsViewModel
    { }

    public class OrderDoctorDetailsViewModel
    { }

    public class OrderDocumentsDetailsViewModel
    { }

    public class OrderConfirmationDetailsViewModel
    { }
}
