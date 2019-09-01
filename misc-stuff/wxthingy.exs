#! /usr/bin/env elixir

defmodule Canvas do
  @behaviour :wx_object

  @title "Canvas Example"
  @size {800, 600}

  def start_link() do
    :wx_object.start_link(__MODULE__, [], [])
  end

  def init(_args \\ []) do
    wx = :wx.new()
    frame = :wxFrame.new(wx, -1, @title, size: @size)
    :wxFrame.connect(frame, :size)
    :wxFrame.connect(frame, :close_window)

    panel = :wxPanel.new(frame, [])
    :wxPanel.connect(panel, :paint, [:callback])

    :wxFrame.show(frame)

    state = %{panel: panel}
    {frame, state}
  end

  def handle_event({:wx, _, _, _, {:wxSize, :size, size, _}}, state = %{panel: panel}) do
    :wxPanel.setSize(panel, size)
    {:noreply, state}
  end

  def handle_event({:wx, _, _, _, {:wxClose, :close_window}}, state) do
    {:stop, :normal, state}
  end

  def handle_sync_event({:wx, _, _, _, {:wxPaint, :paint}}, _, _state = %{panel: panel}) do
    brush = :wxBrush.new()
    :wxBrush.setColour(brush, {0, 0, 0, 0})

    dc = :wxPaintDC.new(panel)
    :wxDC.setBackground(dc, brush)
    :wxDC.clear(dc)
    :wxPaintDC.destroy(dc)
    :ok
  end
end

defmodule Script do
  def main(_args) do
    {:wx_ref, _, _, pid} = Canvas.start_link()
    ref = Process.monitor(pid)

    receive do
      {:DOWN, ^ref, _, _, _} ->
        :ok
    end
  end
end

Script.main(System.argv())
