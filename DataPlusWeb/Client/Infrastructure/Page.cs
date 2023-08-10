using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Rendering;
using Telerik.Blazor.Components.Common;

namespace DataPlusWeb.Client.Infrastructure
{
    public class Page : BaseComponent
    {
        [Parameter]
        public Type PageType { get; set; }

        protected override void OnParametersSet()
        {
            if (PageType is null)
                throw new ArgumentException($"{nameof(PageType)} is required", nameof(PageType));

            if (!PageType.IsAssignableTo(typeof(PageBase)))
                throw new ArgumentException($"{PageType} should be derived from following type: {typeof(PageBase).FullName}", nameof(PageType));

            base.OnParametersSet();
        }

        protected override void BuildRenderTree(RenderTreeBuilder builder)
        {
            builder.OpenComponent(0, PageType);
            builder.CloseComponent();
        }
    }
}
