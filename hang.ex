defmodule CoreWeb.Components.Feedback.Create.Stepper do
  def conditional_stepper_item(assigns) do
    ~H"""
<.some_component a={    <.async_result :let={value} assign={@result}>
      <:loading>

      </:loading>
    </.async_result>
    """
  end

  def selected_stepper_item(assigns) do
    ~H"""
    <li>
      <span>
        <Icons.from_name name={@icon} solid class="w-3.5 h-3.5 text-gray-500 dark:text-gray-400" />
      </span>
      <h3 class="font-medium leading-tight"><%= @title %></h3>
      <p class="text-sm truncate"><%= @description %></p>
    </li>
    """
  end

  attr :title, :string, required: true
  attr :description, :string, required: true

  attr :icon, :atom, required: true

  attr :event, :string, default: nil

  attr :target, CID, required: true

  def stepper_item(assigns) do
    ~H"""
    <li class="mb-10 ps-6 pr-2 hover:bg-gray-200 rounded-lg cursor-pointer" phx-click={@event} phx-target={@target}>
      <span class="absolute flex items-center justify-center w-8 h-8 bg-gray-100 rounded-full -start-4 ring-4 ring-white dark:ring-gray-900 dark:bg-gray-700">
        <Icons.from_name name={@icon} solid class="w-3.5 h-3.5 text-gray-500 dark:text-gray-400" />
      </span>
      <h3 class="font-medium leading-tight"><%= @title %></h3>
      <p class="text-sm truncate"><%= @description %></p>
    </li>
    """
  end
end
