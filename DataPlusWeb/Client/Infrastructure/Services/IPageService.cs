using System.Collections.Specialized;

namespace DataPlusWeb.Client.Infrastructure
{
    public interface IPageService
    {
        IReadOnlyCollection<PageInfo> AllPages { get; }

        IReadOnlyCollection<PageObject> OpenedPages { get; }

        void OpenPage(PageInfo pageInfo);

        event EventHandler<PageObject> PageOpened;
    }
}
