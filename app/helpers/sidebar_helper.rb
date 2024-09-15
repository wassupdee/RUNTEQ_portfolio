module SidebarHelper
  def active_class(path)
    "bg-stone-500 text-white hover:bg-gray-100 hover:text-black" if current_page?(path)
  end
end