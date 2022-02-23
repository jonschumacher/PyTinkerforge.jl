


export BrickletDualButtonLEDState
struct BrickletDualButtonLEDState
    led_l::Integer
    led_r::Integer
end

export BrickletDualButtonButtonState
struct BrickletDualButtonButtonState
    button_l::Integer
    button_r::Integer
end

export BrickletDualButtonIdentity
struct BrickletDualButtonIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletDualButton
"""
Two tactile buttons with built-in blue LEDs
"""
mutable struct BrickletDualButton <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletDualButton(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_dual_button")
        deviceInternal = package.BrickletDualButton(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export set_led_state
"""
    $(SIGNATURES)

Sets the state of the LEDs. Possible states are:

* 0 = AutoToggleOn: Enables auto toggle with initially enabled LED.
* 1 = AutoToggleOff: Activates auto toggle with initially disabled LED.
* 2 = On: Enables LED (auto toggle is disabled).
* 3 = Off: Disables LED (auto toggle is disabled).

In auto toggle mode the LED is toggled automatically at each press of a button.

If you just want to set one of the LEDs and don't know the current state
of the other LED, you can get the state with :func:`Get LED State` or you
can use :func:`Set Selected LED State`.
"""
function set_led_state(device::BrickletDualButton, led_l, led_r)
    device.deviceInternal.set_led_state(led_l, led_r)
end

export get_led_state
"""
    $(SIGNATURES)

Returns the current state of the LEDs, as set by :func:`Set LED State`.
"""
function get_led_state(device::BrickletDualButton)
    return device.deviceInternal.get_led_state()
end

export get_button_state
"""
    $(SIGNATURES)

Returns the current state for both buttons. Possible states are:

* 0 = pressed
* 1 = released
"""
function get_button_state(device::BrickletDualButton)
    return device.deviceInternal.get_button_state()
end

export set_selected_led_state
"""
    $(SIGNATURES)

Sets the state of the selected LED (0 or 1).

The other LED remains untouched.
"""
function set_selected_led_state(device::BrickletDualButton, led, state)
    device.deviceInternal.set_selected_led_state(led, state)
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
function get_identity(device::BrickletDualButton)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletDualButton, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
