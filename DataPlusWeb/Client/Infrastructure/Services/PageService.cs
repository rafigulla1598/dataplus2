namespace DataPlusWeb.Client.Infrastructure;

public class PageService : IPageService
{
    private static readonly List<PageInfo> _devPages = new() {
        new() { Name = "data-entry", Path = "Data Entry", Title = "Data Entry", PageType = typeof(Pages.Demo) },
        new() { Name = "order-search", Path = "Orders/Search", Title = "Order search", PageType = typeof(Pages.Orders.Orders) },
        new() { Name = "calling", Path = "Calling", Title = "Calling", PageType = typeof(Pages.Demo) },
        new() { Name = "routing", Path = "Routing", Title = "Routing", PageType = typeof(Pages.Demo) },
        new() { Name = "quality Control", Path = "Quality Control", Title = "Quality Control", PageType = typeof(Pages.Demo) },
        new() { Name = "billing", Path = "Billing", Title = "Billing", PageType = typeof(Pages.Demo) },
        new() { Name = "accounting", Path = "Accounting", Title = "Accounting", PageType = typeof(Pages.Demo) },
        new() { Name = "masters", Path = "Masters", Title = "Masters", PageType = typeof(Pages.Demo) },
        new() { Name = "administration", Path = "Administration", Title = "Administration", PageType = typeof(Pages.Demo) },
        new() { Name = "reports", Path = "Reports", Title = "Reports", PageType = typeof(Pages.Demo) },

        new() { Name = "order-details", Path = "OrderDetails", Title = "OrderDetails", PageType = typeof(Pages.Orders.OrdersDetails) }
    };

    private readonly List<PageInfo> _allPages = _devPages.ToList();

    private readonly List<PageObject> _openedPages = new();// _devPages.Select(i => new PageObject() { Info = i }).ToList();

    public IReadOnlyCollection<PageInfo> AllPages => _allPages;

    public IReadOnlyCollection<PageObject> OpenedPages => _openedPages;

    public event EventHandler<PageObject> PageOpened;

    public void OpenPage(PageInfo pageInfo)
    {
        var pageObj = new PageObject() { Info = pageInfo, Instance = null };
        _openedPages.Add(pageObj);
        PageOpened?.Invoke(this, pageObj);
    }
}
