


export BrickletLCD128x64ReadPixelsLowLevel
struct BrickletLCD128x64ReadPixelsLowLevel
    pixels_length::Integer
    pixels_chunk_offset::Integer
    pixels_chunk_data::Vector{Bool}
end

export BrickletLCD128x64DisplayConfiguration
struct BrickletLCD128x64DisplayConfiguration
    contrast::Integer
    backlight::Integer
    invert::Bool
    automatic_draw::Bool
end

export BrickletLCD128x64TouchPosition
struct BrickletLCD128x64TouchPosition
    pressure::Integer
    x::Integer
    y::Integer
    age::Integer
end

export BrickletLCD128x64TouchPositionCallbackConfiguration
struct BrickletLCD128x64TouchPositionCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
end

export BrickletLCD128x64TouchGesture
struct BrickletLCD128x64TouchGesture
    gesture::Integer
    duration::Integer
    pressure_max::Integer
    x_start::Integer
    y_start::Integer
    x_end::Integer
    y_end::Integer
    age::Integer
end

export BrickletLCD128x64TouchGestureCallbackConfiguration
struct BrickletLCD128x64TouchGestureCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
end

export BrickletLCD128x64GUIButton
struct BrickletLCD128x64GUIButton
    active::Bool
    position_x::Integer
    position_y::Integer
    width::Integer
    height::Integer
    text::String
end

export BrickletLCD128x64GUIButtonPressedCallbackConfiguration
struct BrickletLCD128x64GUIButtonPressedCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
end

export BrickletLCD128x64GUISlider
struct BrickletLCD128x64GUISlider
    active::Bool
    position_x::Integer
    position_y::Integer
    length::Integer
    direction::Integer
    value::Integer
end

export BrickletLCD128x64GUISliderValueCallbackConfiguration
struct BrickletLCD128x64GUISliderValueCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
end

export BrickletLCD128x64GUITabConfiguration
struct BrickletLCD128x64GUITabConfiguration
    change_tab_config::Integer
    clear_gui::Bool
end

export BrickletLCD128x64GUITabText
struct BrickletLCD128x64GUITabText
    active::Bool
    text::String
end

export BrickletLCD128x64GUITabIcon
struct BrickletLCD128x64GUITabIcon
    active::Bool
    icon::Vector{Bool}
end

export BrickletLCD128x64GUITabSelectedCallbackConfiguration
struct BrickletLCD128x64GUITabSelectedCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
end

export BrickletLCD128x64GUIGraphConfiguration
struct BrickletLCD128x64GUIGraphConfiguration
    active::Bool
    graph_type::Integer
    position_x::Integer
    position_y::Integer
    width::Integer
    height::Integer
    text_x::String
    text_y::String
end

export BrickletLCD128x64GUIGraphDataLowLevel
struct BrickletLCD128x64GUIGraphDataLowLevel
    data_length::Integer
    data_chunk_offset::Integer
    data_chunk_data::Vector{Integer}
end

export BrickletLCD128x64SPITFPErrorCount
struct BrickletLCD128x64SPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletLCD128x64Identity
struct BrickletLCD128x64Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletLCD128x64
"""
7.1cm (2.8") display with 128x64 pixel and touch screen
"""
mutable struct BrickletLCD128x64 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletLCD128x64(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_lcd_128x64")
        deviceInternal = package.BrickletLCD128x64(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export write_pixels_low_level
"""
    $(SIGNATURES)

Writes pixels to the specified window.

The pixels are written into the window line by line top to bottom
and each line is written from left to right.

If automatic draw is enabled (default) the pixels are directly written to
the screen. Only pixels that have actually changed are updated on the screen,
the rest stays the same.

If automatic draw is disabled the pixels are written to an internal buffer and
the buffer is transferred to the display only after :func:`Draw Buffered Frame`
is called. This can be used to avoid flicker when drawing a complex frame in
multiple steps.

Automatic draw can be configured with the :func:`Set Display Configuration`
function.
"""
function write_pixels_low_level(device::BrickletLCD128x64, x_start, y_start, x_end, y_end, pixels_length, pixels_chunk_offset, pixels_chunk_data)
    device.deviceInternal.write_pixels_low_level(x_start, y_start, x_end, y_end, pixels_length, pixels_chunk_offset, pixels_chunk_data)
end

export read_pixels_low_level
"""
    $(SIGNATURES)

Reads pixels from the specified window.

The pixels are read from the window line by line top to bottom
and each line is read from left to right.

If automatic draw is enabled (default) the pixels that are read are always the
same that are shown on the display.

If automatic draw is disabled the pixels are read from the internal buffer
(see :func:`Draw Buffered Frame`).

Automatic draw can be configured with the :func:`Set Display Configuration`
function.
"""
function read_pixels_low_level(device::BrickletLCD128x64, x_start, y_start, x_end, y_end)
    return device.deviceInternal.read_pixels_low_level(x_start, y_start, x_end, y_end)
end

export clear_display
"""
    $(SIGNATURES)

Clears the complete content of the display.

If automatic draw is enabled (default) the pixels are directly cleared.

If automatic draw is disabled the the internal buffer is cleared and
the buffer is transferred to the display only after :func:`Draw Buffered Frame`
is called. This can be used to avoid flicker when drawing a complex frame in
multiple steps.

Automatic draw can be configured with the :func:`Set Display Configuration`
function.
"""
function clear_display(device::BrickletLCD128x64)
    device.deviceInternal.clear_display()
end

export set_display_configuration
"""
    $(SIGNATURES)

Sets the configuration of the display.

If automatic draw is set to *true*, the display is automatically updated with every
call of :func:`Write Pixels` and :func:`Write Line`. If it is set to false, the
changes are written into an internal buffer and only shown on the display after
a call of :func:`Draw Buffered Frame`.
"""
function set_display_configuration(device::BrickletLCD128x64, contrast, backlight, invert, automatic_draw)
    device.deviceInternal.set_display_configuration(contrast, backlight, invert, automatic_draw)
end

export get_display_configuration
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Display Configuration`.
"""
function get_display_configuration(device::BrickletLCD128x64)
    return device.deviceInternal.get_display_configuration()
end

export write_line
"""
    $(SIGNATURES)

Writes text to a specific line with a specific position.

For example: (1, 10, "Hello") will write *Hello* in the middle of the
second line of the display.

The display uses a special 5x7 pixel charset. You can view the characters
of the charset in Brick Viewer.

If automatic draw is enabled (default) the text is directly written to
the screen. Only pixels that have actually changed are updated on the screen,
the rest stays the same.

If automatic draw is disabled the text is written to an internal buffer and
the buffer is transferred to the display only after :func:`Draw Buffered Frame`
is called. This can be used to avoid flicker when drawing a complex frame in
multiple steps.

Automatic draw can be configured with the :func:`Set Display Configuration`
function.

This function is a 1:1 replacement for the function with the same name
in the LCD 20x4 Bricklet. You can draw text at a specific pixel position
and with different font sizes with the :func:`Draw Text` function.
"""
function write_line(device::BrickletLCD128x64, line, position, text)
    device.deviceInternal.write_line(line, position, text)
end

export draw_buffered_frame
"""
    $(SIGNATURES)

Draws the currently buffered frame. Normally each call of :func:`Write Pixels` and
:func:`Write Line` draws directly onto the display. If you turn automatic draw off
(:func:`Set Display Configuration`), the data is written in an internal buffer and
only transferred to the display by calling this function. This can be used to
avoid flicker when drawing a complex frame in multiple steps.

Set the `force complete redraw` to *true* to redraw the whole display
instead of only the changed parts. Normally it should not be necessary to set this to
*true*. It may only become necessary in case of stuck pixels because of errors.
"""
function draw_buffered_frame(device::BrickletLCD128x64, force_complete_redraw)
    device.deviceInternal.draw_buffered_frame(force_complete_redraw)
end

export get_touch_position
"""
    $(SIGNATURES)

Returns the last valid touch position:

* Pressure: Amount of pressure applied by the user
* X: Touch position on x-axis
* Y: Touch position on y-axis
* Age: Age of touch press (how long ago it was)
"""
function get_touch_position(device::BrickletLCD128x64)
    return device.deviceInternal.get_touch_position()
end

export set_touch_position_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Touch Position` callback
is triggered periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change within the
period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.
"""
function set_touch_position_callback_configuration(device::BrickletLCD128x64, period, value_has_to_change)
    device.deviceInternal.set_touch_position_callback_configuration(period, value_has_to_change)
end

export get_touch_position_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by
:func:`Set Touch Position Callback Configuration`.
"""
function get_touch_position_callback_configuration(device::BrickletLCD128x64)
    return device.deviceInternal.get_touch_position_callback_configuration()
end

export get_touch_gesture
"""
    $(SIGNATURES)

Returns one of four touch gestures that can be automatically detected by the Bricklet.

The gestures are swipes from left to right, right to left, top to bottom and bottom to top.

Additionally to the gestures a vector with a start and end position of the gesture is
provided. You can use this vector do determine a more exact location of the gesture (e.g.
the swipe from top to bottom was on the left or right part of the screen).

The age parameter corresponds to the age of gesture (how long ago it was).
"""
function get_touch_gesture(device::BrickletLCD128x64)
    return device.deviceInternal.get_touch_gesture()
end

export set_touch_gesture_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Touch Gesture` callback
is triggered periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change within the
period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.
"""
function set_touch_gesture_callback_configuration(device::BrickletLCD128x64, period, value_has_to_change)
    device.deviceInternal.set_touch_gesture_callback_configuration(period, value_has_to_change)
end

export get_touch_gesture_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by
:func:`Set Touch Gesture Callback Configuration`.
"""
function get_touch_gesture_callback_configuration(device::BrickletLCD128x64)
    return device.deviceInternal.get_touch_gesture_callback_configuration()
end

export draw_line
"""
    $(SIGNATURES)

Draws a white or black line from (x, y)-start to (x, y)-end.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function draw_line(device::BrickletLCD128x64, position_x_start, position_y_start, position_x_end, position_y_end, color)
    device.deviceInternal.draw_line(position_x_start, position_y_start, position_x_end, position_y_end, color)
end

export draw_box
"""
    $(SIGNATURES)

Draws a white or black box from (x, y)-start to (x, y)-end.

If you set fill to true, the box will be filled with the
color. Otherwise only the outline will be drawn.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function draw_box(device::BrickletLCD128x64, position_x_start, position_y_start, position_x_end, position_y_end, fill, color)
    device.deviceInternal.draw_box(position_x_start, position_y_start, position_x_end, position_y_end, fill, color)
end

export draw_text
"""
    $(SIGNATURES)

Draws a text at the pixel position (x, y).

You can use one of 9 different font sizes and draw the text in white or black.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function draw_text(device::BrickletLCD128x64, position_x, position_y, font, color, text)
    device.deviceInternal.draw_text(position_x, position_y, font, color, text)
end

export set_gui_button
"""
    $(SIGNATURES)

Draws a clickable button at position (x, y) with the given text.

You can use up to 12 buttons.

The x position + width has to be within the range of 1 to 128 and the y
position + height has to be within the range of 1 to 64.

The minimum useful width/height of a button is 3.

You can enable a callback for a button press with
:func:`Set GUI Button Pressed Callback Configuration`. The callback will
be triggered for press and release-events.

The button is drawn in a separate GUI buffer and the button-frame will
always stay on top of the graphics drawn with :func:`Write Pixels`. To
remove the button use :func:`Remove GUI Button`.

If you want an icon instead of text, you can draw the icon inside of the
button with :func:`Write Pixels`.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function set_gui_button(device::BrickletLCD128x64, index, position_x, position_y, width, height, text)
    device.deviceInternal.set_gui_button(index, position_x, position_y, width, height, text)
end

export get_gui_button
"""
    $(SIGNATURES)

Returns the button properties for a given `Index` as set by :func:`Set GUI Button`.

Additionally the `Active` parameter shows if a button is currently active/visible
or not.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function get_gui_button(device::BrickletLCD128x64, index)
    return device.deviceInternal.get_gui_button(index)
end

export remove_gui_button
"""
    $(SIGNATURES)

Removes the button with the given index.

You can use index 255 to remove all buttons.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function remove_gui_button(device::BrickletLCD128x64, index)
    device.deviceInternal.remove_gui_button(index)
end

export set_gui_button_pressed_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`GUI Button Pressed` callback
is triggered periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change within the
period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function set_gui_button_pressed_callback_configuration(device::BrickletLCD128x64, period, value_has_to_change)
    device.deviceInternal.set_gui_button_pressed_callback_configuration(period, value_has_to_change)
end

export get_gui_button_pressed_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by
:func:`Set GUI Button Pressed Callback Configuration`.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function get_gui_button_pressed_callback_configuration(device::BrickletLCD128x64)
    return device.deviceInternal.get_gui_button_pressed_callback_configuration()
end

export get_gui_button_pressed
"""
    $(SIGNATURES)

Returns the state of the button for the given index.

The state can either be pressed (true) or released (false).

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function get_gui_button_pressed(device::BrickletLCD128x64, index)
    return device.deviceInternal.get_gui_button_pressed(index)
end

export set_gui_slider
"""
    $(SIGNATURES)

Draws a slider at position (x, y) with the given length.

You can use up to 6 sliders.

If you use the horizontal direction, the x position + length has to be
within the range of 1 to 128 and the y position has to be within
the range of 0 to 46.

If you use the vertical direction, the y position + length has to be
within the range of 1 to 64 and the x position has to be within
the range of 0 to 110.

The minimum length of a slider is 8.

The parameter value is the start-position of the slider, it can
be between 0 and length-8.

You can enable a callback for the slider value with
:func:`Set GUI Slider Value Callback Configuration`.

The slider is drawn in a separate GUI buffer and it will
always stay on top of the graphics drawn with :func:`Write Pixels`. To
remove the button use :func:`Remove GUI Slider`.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function set_gui_slider(device::BrickletLCD128x64, index, position_x, position_y, length, direction, value)
    device.deviceInternal.set_gui_slider(index, position_x, position_y, length, direction, value)
end

export get_gui_slider
"""
    $(SIGNATURES)

Returns the slider properties for a given `Index` as set by :func:`Set GUI Slider`.

Additionally the `Active` parameter shows if a button is currently active/visible
or not.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function get_gui_slider(device::BrickletLCD128x64, index)
    return device.deviceInternal.get_gui_slider(index)
end

export remove_gui_slider
"""
    $(SIGNATURES)

Removes the slider with the given index.

You can use index 255 to remove all slider.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function remove_gui_slider(device::BrickletLCD128x64, index)
    device.deviceInternal.remove_gui_slider(index)
end

export set_gui_slider_value_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`GUI Slider Value` callback
is triggered periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change within the
period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function set_gui_slider_value_callback_configuration(device::BrickletLCD128x64, period, value_has_to_change)
    device.deviceInternal.set_gui_slider_value_callback_configuration(period, value_has_to_change)
end

export get_gui_slider_value_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by
:func:`Set GUI Slider Value Callback Configuration`.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function get_gui_slider_value_callback_configuration(device::BrickletLCD128x64)
    return device.deviceInternal.get_gui_slider_value_callback_configuration()
end

export get_gui_slider_value
"""
    $(SIGNATURES)

Returns the current slider value for the given index.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function get_gui_slider_value(device::BrickletLCD128x64, index)
    return device.deviceInternal.get_gui_slider_value(index)
end

export set_gui_tab_configuration
"""
    $(SIGNATURES)

Sets the general configuration for tabs. You can configure the tabs to only
accept clicks or only swipes (gesture left/right and right/left) or both.

Additionally, if you set `Clear GUI` to true, all of the GUI elements (buttons,
slider, graphs) will automatically be removed on every tab change.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function set_gui_tab_configuration(device::BrickletLCD128x64, change_tab_config, clear_gui)
    device.deviceInternal.set_gui_tab_configuration(change_tab_config, clear_gui)
end

export get_gui_tab_configuration
"""
    $(SIGNATURES)

Returns the tab configuration as set by :func:`Set GUI Tab Configuration`.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function get_gui_tab_configuration(device::BrickletLCD128x64)
    return device.deviceInternal.get_gui_tab_configuration()
end

export set_gui_tab_text
"""
    $(SIGNATURES)

Adds a text-tab with the given index.

You can use up to 10 tabs.

A text-tab with the same index as a icon-tab will overwrite the icon-tab.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function set_gui_tab_text(device::BrickletLCD128x64, index, text)
    device.deviceInternal.set_gui_tab_text(index, text)
end

export get_gui_tab_text
"""
    $(SIGNATURES)

Returns the text for a given index as set by :func:`Set GUI Tab Text`.

Additionally the `Active` parameter shows if the tab is currently active/visible
or not.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function get_gui_tab_text(device::BrickletLCD128x64, index)
    return device.deviceInternal.get_gui_tab_text(index)
end

export set_gui_tab_icon
"""
    $(SIGNATURES)

Adds a icon-tab with the given index. The icon can have a width of 28 pixels
with a height of 6 pixels. It is drawn line-by-line from left to right.

You can use up to 10 tabs.

A icon-tab with the same index as a text-tab will overwrite the text-tab.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function set_gui_tab_icon(device::BrickletLCD128x64, index, icon)
    device.deviceInternal.set_gui_tab_icon(index, icon)
end

export get_gui_tab_icon
"""
    $(SIGNATURES)

Returns the icon for a given index as set by :func:`Set GUI Tab Icon`.

Additionally the `Active` parameter shows if the tab is currently active/visible
or not.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function get_gui_tab_icon(device::BrickletLCD128x64, index)
    return device.deviceInternal.get_gui_tab_icon(index)
end

export remove_gui_tab
"""
    $(SIGNATURES)

Removes the tab with the given index.

You can use index 255 to remove all tabs.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function remove_gui_tab(device::BrickletLCD128x64, index)
    device.deviceInternal.remove_gui_tab(index)
end

export set_gui_tab_selected
"""
    $(SIGNATURES)

Sets the tab with the given index as selected (drawn as selected on the display).

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function set_gui_tab_selected(device::BrickletLCD128x64, index)
    device.deviceInternal.set_gui_tab_selected(index)
end

export set_gui_tab_selected_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`GUI Tab Selected` callback
is triggered periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change within the
period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function set_gui_tab_selected_callback_configuration(device::BrickletLCD128x64, period, value_has_to_change)
    device.deviceInternal.set_gui_tab_selected_callback_configuration(period, value_has_to_change)
end

export get_gui_tab_selected_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by
:func:`Set GUI Tab Selected Callback Configuration`.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function get_gui_tab_selected_callback_configuration(device::BrickletLCD128x64)
    return device.deviceInternal.get_gui_tab_selected_callback_configuration()
end

export get_gui_tab_selected
"""
    $(SIGNATURES)

Returns the index of the currently selected tab.
If there are not tabs, the returned index is -1.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function get_gui_tab_selected(device::BrickletLCD128x64)
    return device.deviceInternal.get_gui_tab_selected()
end

export set_gui_graph_configuration
"""
    $(SIGNATURES)

Sets the configuration for up to four graphs.

The graph type can be dot-, line- or bar-graph.

The x and y position are pixel positions.

You can add a text for the x and y axis.
The text is drawn at the inside of the graph and it can overwrite some
of the graph data. If you need the text outside of the graph you can
leave this text here empty and use :func:`Draw Text` to draw the caption
outside of the graph.

The data of the graph can be set and updated with :func:`Set GUI Graph Data`.

The graph is drawn in a separate GUI buffer and the graph-frame and data will
always stay on top of the graphics drawn with :func:`Write Pixels`. To
remove the graph use :func:`Remove GUI Graph`.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function set_gui_graph_configuration(device::BrickletLCD128x64, index, graph_type, position_x, position_y, width, height, text_x, text_y)
    device.deviceInternal.set_gui_graph_configuration(index, graph_type, position_x, position_y, width, height, text_x, text_y)
end

export get_gui_graph_configuration
"""
    $(SIGNATURES)

Returns the graph properties for a given `Index` as set by :func:`Set GUI Graph Configuration`.

Additionally the `Active` parameter shows if a graph is currently active/visible
or not.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function get_gui_graph_configuration(device::BrickletLCD128x64, index)
    return device.deviceInternal.get_gui_graph_configuration(index)
end

export set_gui_graph_data_low_level
"""
    $(SIGNATURES)

Sets the data for a graph with the given index. You have to configure the graph with
:func:`Set GUI Graph Configuration` before you can set the first data.

The graph will show the first n values of the data that you set, where
n is the width set with :func:`Set GUI Graph Configuration`. If you set
less then n values it will show the rest of the values as zero.

The maximum number of data-points you can set is 118 (which also corresponds to the
maximum width of the graph).

You have to scale your values to be between 0 and 255. 0 will be shown
at the bottom of the graph and 255 at the top.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function set_gui_graph_data_low_level(device::BrickletLCD128x64, index, data_length, data_chunk_offset, data_chunk_data)
    device.deviceInternal.set_gui_graph_data_low_level(index, data_length, data_chunk_offset, data_chunk_data)
end

export get_gui_graph_data_low_level
"""
    $(SIGNATURES)

Returns the graph data for a given index as set by :func:`Set GUI Graph Data`.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function get_gui_graph_data_low_level(device::BrickletLCD128x64, index)
    return device.deviceInternal.get_gui_graph_data_low_level(index)
end

export remove_gui_graph
"""
    $(SIGNATURES)

Removes the graph with the given index.

You can use index 255 to remove all graphs.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function remove_gui_graph(device::BrickletLCD128x64, index)
    device.deviceInternal.remove_gui_graph(index)
end

export remove_all_gui
"""
    $(SIGNATURES)

Removes all GUI elements (buttons, slider, graphs, tabs).

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function remove_all_gui(device::BrickletLCD128x64)
    device.deviceInternal.remove_all_gui()
end

export set_touch_led_config
"""
    $(SIGNATURES)

Sets the touch LED configuration. By default the LED is on if the
LCD is touched.

You can also turn the LED permanently on/off or show a heartbeat.

If the Bricklet is in bootloader mode, the LED is off.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function set_touch_led_config(device::BrickletLCD128x64, config)
    device.deviceInternal.set_touch_led_config(config)
end

export get_touch_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Touch LED Config`

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function get_touch_led_config(device::BrickletLCD128x64)
    return device.deviceInternal.get_touch_led_config()
end

export get_spitfp_error_count
"""
    $(SIGNATURES)

Returns the error count for the communication between Brick and Bricklet.

The errors are divided into

* ACK checksum errors,
* message checksum errors,
* framing errors and
* overflow errors.

The errors counts are for errors that occur on the Bricklet side. All
Bricks have a similar function that returns the errors on the Brick side.
"""
function get_spitfp_error_count(device::BrickletLCD128x64)
    return device.deviceInternal.get_spitfp_error_count()
end

export set_bootloader_mode
"""
    $(SIGNATURES)

Sets the bootloader mode and returns the status after the requested
mode change was instigated.

You can change from bootloader mode to firmware mode and vice versa. A change
from bootloader mode to firmware mode will only take place if the entry function,
device identifier and CRC are present and correct.

This function is used by Brick Viewer during flashing. It should not be
necessary to call it in a normal user program.
"""
function set_bootloader_mode(device::BrickletLCD128x64, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletLCD128x64)
    return device.deviceInternal.get_bootloader_mode()
end

export set_write_firmware_pointer
"""
    $(SIGNATURES)

Sets the firmware pointer for :func:`Write Firmware`. The pointer has
to be increased by chunks of size 64. The data is written to flash
every 4 chunks (which equals to one page of size 256).

This function is used by Brick Viewer during flashing. It should not be
necessary to call it in a normal user program.
"""
function set_write_firmware_pointer(device::BrickletLCD128x64, pointer)
    device.deviceInternal.set_write_firmware_pointer(pointer)
end

export write_firmware
"""
    $(SIGNATURES)

Writes 64 Bytes of firmware at the position as written by
:func:`Set Write Firmware Pointer` before. The firmware is written
to flash every 4 chunks.

You can only write firmware in bootloader mode.

This function is used by Brick Viewer during flashing. It should not be
necessary to call it in a normal user program.
"""
function write_firmware(device::BrickletLCD128x64, data)
    return device.deviceInternal.write_firmware(data)
end

export set_status_led_config
"""
    $(SIGNATURES)

Sets the status LED configuration. By default the LED shows
communication traffic between Brick and Bricklet, it flickers once
for every 10 received data packets.

You can also turn the LED permanently on/off or show a heartbeat.

If the Bricklet is in bootloader mode, the LED is will show heartbeat by default.
"""
function set_status_led_config(device::BrickletLCD128x64, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletLCD128x64)
    return device.deviceInternal.get_status_led_config()
end

export get_chip_temperature
"""
    $(SIGNATURES)

Returns the temperature as measured inside the microcontroller. The
value returned is not the ambient temperature!

The temperature is only proportional to the real temperature and it has bad
accuracy. Practically it is only useful as an indicator for
temperature changes.
"""
function get_chip_temperature(device::BrickletLCD128x64)
    return device.deviceInternal.get_chip_temperature()
end

export reset
"""
    $(SIGNATURES)

Calling this function will reset the Bricklet. All configurations
will be lost.

After a reset you have to create new device objects,
calling functions on the existing ones will result in
undefined behavior!
"""
function reset(device::BrickletLCD128x64)
    device.deviceInternal.reset()
end

export write_uid
"""
    $(SIGNATURES)

Writes a new UID into flash. If you want to set a new UID
you have to decode the Base58 encoded UID string into an
integer first.

We recommend that you use Brick Viewer to change the UID.
"""
function write_uid(device::BrickletLCD128x64, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletLCD128x64)
    return device.deviceInternal.read_uid()
end

export get_identity
"""
    $(SIGNATURES)

Returns the UID, the UID where the Bricklet is connected to,
the position, the hardware and firmware version as well as the
device identifier.

The position can be 'a', 'b', 'c', 'd', 'e', 'f', 'g' or 'h' (Bricklet Port).
A Bricklet connected to an :ref:`Isolator Bricklet <isolator_bricklet>` is always at
position 'z'.

The device identifier numbers can be found :ref:`here <device_identifier>`.
|device_identifier_constant|
"""
function get_identity(device::BrickletLCD128x64)
    return device.deviceInternal.get_identity()
end

export write_pixels
"""
Writes pixels to the specified window.

The pixels are written into the window line by line top to bottom
and each line is written from left to right.

If automatic draw is enabled (default) the pixels are directly written to
the screen. Only pixels that have actually changed are updated on the screen,
the rest stays the same.

If automatic draw is disabled the pixels are written to an internal buffer and
the buffer is transferred to the display only after :func:`Draw Buffered Frame`
is called. This can be used to avoid flicker when drawing a complex frame in
multiple steps.

Automatic draw can be configured with the :func:`Set Display Configuration`
function.
"""
function write_pixels(device::BrickletLCD128x64, x_start, y_start, x_end, y_end, pixels)

        x_start = UInt8(x_start)
    y_start = UInt8(y_start)
    x_end = UInt8(x_end)
    y_end = UInt8(y_end)
    pixels = convert(Vector{Bool}, pixels)

    if length(pixels) > 65535
        throw(TinkerforgeInvalidParameterError("Pixels can be at most 65535 items long"))
    end

    pixels_length = length(pixels)
    pixels_chunk_offset = 0

    if pixels_length == 0
        pixels_chunk_data = [False] * 448
        ret = write_pixels_low_level(device, x_start, y_start, x_end, y_end, pixels_length, pixels_chunk_offset, pixels_chunk_data)
    else
        lock(device.stream_lock) do
            while pixels_chunk_offset < pixels_length
                pixels_chunk_data = create_chunk_data(pixels, pixels_chunk_offset, 448, False)
                ret = write_pixels_low_level(device, x_start, y_start, x_end, y_end, pixels_length, pixels_chunk_offset, pixels_chunk_data)
                pixels_chunk_offset += 448
            end
        end
    end

        return ret
end

export read_pixels
"""
Reads pixels from the specified window.

The pixels are read from the window line by line top to bottom
and each line is read from left to right.

If automatic draw is enabled (default) the pixels that are read are always the
same that are shown on the display.

If automatic draw is disabled the pixels are read from the internal buffer
(see :func:`Draw Buffered Frame`).

Automatic draw can be configured with the :func:`Set Display Configuration`
function.
"""
function read_pixels(device::BrickletLCD128x64, x_start, y_start, x_end, y_end)

        x_start = UInt8(x_start)
    y_start = UInt8(y_start)
    x_end = UInt8(x_end)
    y_end = UInt8(y_end)

    lock(device.stream_lock) do
        ret = read_pixels_low_level(device, x_start, y_start, x_end, y_end)
            pixels_length = ret.pixels_length
        pixels_out_of_sync = ret.pixels_chunk_offset != 0

        pixels_data = ret.pixels_chunk_data

        while !pixels_out_of_sync && length(pixels_data) < pixels_length
            ret = read_pixels_low_level(device, x_start, y_start, x_end, y_end)
                pixels_length = ret.pixels_length
            pixels_out_of_sync = ret.pixels_chunk_offset != length(pixels_data)
            pixels_data += ret.pixels_chunk_data
        end

        if pixels_out_of_sync # discard remaining stream to bring it back in-sync
            while ret.pixels_chunk_offset + 480 < pixels_length
                ret = read_pixels_low_level(device, x_start, y_start, x_end, y_end)
                    pixels_length = ret.pixels_length
            end

            throw(TinkerforgeStreamOutOfSyncError("Pixels stream is out-of-sync"))
        end
    end

        return pixels_data[:pixels_length]
end

export set_gui_graph_data
"""
Sets the data for a graph with the given index. You have to configure the graph with
:func:`Set GUI Graph Configuration` before you can set the first data.

The graph will show the first n values of the data that you set, where
n is the width set with :func:`Set GUI Graph Configuration`. If you set
less then n values it will show the rest of the values as zero.

The maximum number of data-points you can set is 118 (which also corresponds to the
maximum width of the graph).

You have to scale your values to be between 0 and 255. 0 will be shown
at the bottom of the graph and 255 at the top.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function set_gui_graph_data(device::BrickletLCD128x64, index, data)

        index = UInt8(index)
    data = convert(Vector{UInt8}, data)

    if length(data) > 65535
        throw(TinkerforgeInvalidParameterError("Data can be at most 65535 items long"))
    end

    data_length = length(data)
    data_chunk_offset = 0

    if data_length == 0
        data_chunk_data = [0] * 59
        ret = set_gui_graph_data_low_level(device, index, data_length, data_chunk_offset, data_chunk_data)
    else
        lock(device.stream_lock) do
            while data_chunk_offset < data_length
                data_chunk_data = create_chunk_data(data, data_chunk_offset, 59, 0)
                ret = set_gui_graph_data_low_level(device, index, data_length, data_chunk_offset, data_chunk_data)
                data_chunk_offset += 59
            end
        end
    end

        return ret
end

export get_gui_graph_data
"""
Returns the graph data for a given index as set by :func:`Set GUI Graph Data`.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function get_gui_graph_data(device::BrickletLCD128x64, index)

        index = UInt8(index)

    lock(device.stream_lock) do
        ret = get_gui_graph_data_low_level(device, index)
            data_length = ret.data_length
        data_out_of_sync = ret.data_chunk_offset != 0

        data_data = ret.data_chunk_data

        while !data_out_of_sync && length(data_data) < data_length
            ret = get_gui_graph_data_low_level(device, index)
                data_length = ret.data_length
            data_out_of_sync = ret.data_chunk_offset != length(data_data)
            data_data += ret.data_chunk_data
        end

        if data_out_of_sync # discard remaining stream to bring it back in-sync
            while ret.data_chunk_offset + 59 < data_length
                ret = get_gui_graph_data_low_level(device, index)
                    data_length = ret.data_length
            end

            throw(TinkerforgeStreamOutOfSyncError("Data stream is out-of-sync"))
        end
    end

        return data_data[:data_length]
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletLCD128x64, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
