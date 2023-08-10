using DataPlusWeb.Client.Infrastructure;
using Microsoft.AspNetCore.Components;

namespace DataPlusWeb.Client.Shared;

public partial class TopMenu
{
    private readonly List<MenuItem> _items = new();

    [Inject]
    public IPageService PageService { get; set; }

    protected void OnMenuItemClick(MenuItem item)
    {
        if (item.PageInfo is null) return;

        PageService.OpenPage(item.PageInfo);
        StateHasChanged();
    }

    public class MenuItem
    {
        public string Id { get; init; }
        public string Text { get; init; }
        public string? ParentId { get; set; }

        public PageInfo? PageInfo { get; init; }
    }

    protected override void OnInitialized()
    {
        _items.AddRange(GetMenuItems());

        base.OnInitialized();
    }

    private IEnumerable<MenuItem> GetMenuItems()
    {
        var dic = new Dictionary<string, MenuItem>();

        foreach (var pageInfo in PageService.AllPages)
        {
            var item = new MenuItem
            {
                Id = pageInfo.Path,
                Text = pageInfo.Title,
                PageInfo = pageInfo,
                ParentId = GetOrCreateParentItem(pageInfo.Path)?.Id
            };
            dic.Add(item.Id, item);
        }

        return dic.Values;

        MenuItem? GetOrCreateParentItem(string childPath, int depth = 0)
        {
            var idIndex = childPath.LastIndexOf('/');

            if (idIndex == -1) return null;

            var id = childPath[..idIndex];

            if (!dic.TryGetValue(id, out var parentItem))
                parentItem = GetOrCreateParentItem(id, depth: depth + 1);

            var item = new MenuItem
            {
                Id = id,
                Text = id,
                ParentId = parentItem?.Id
            };
            dic.Add(item.Id, item);

            return item;
        }
    }
}