defmodule InstagramWeb.Resolvers.Posts do
  def get_photo(_, %{id: id}, _) do
    case Instagram.Posts.get_photo(id) do
      nil ->
        {:error, "Photo do not exist"}
      photo ->
        {:ok, photo}
    end
  end

  def list_photos(_, %{offset: offset, limit: limit}, _) do
    {:ok, Instagram.Posts.list_photos(limit, offset)}
  end

  def create_photo(_, args, %{context: %{current_user: current_user}}) do
    args = Map.merge(args, %{user_id: current_user.id})
    with {:ok, photo} <- Instagram.Posts.create_photo(args) do
      {:ok, photo}
    end
  end

  def get_all_tags(_, _, _) do
    {:ok, Instagram.Posts.get_all_tags()}
  end
end