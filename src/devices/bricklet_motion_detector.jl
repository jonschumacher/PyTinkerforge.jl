


export BrickletMotionDetectorIdentity
struct BrickletMotionDetectorIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletMotionDetector
"""
Passive infrared (PIR) motion sensor with 7m range
"""
mutable struct BrickletMotionDetector <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletMotionDetector(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_motion_detector")
        deviceInternal = package.BrickletMotionDetector(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_motion_detected
"""
    $(SIGNATURES)

Returns 1 if a motion was detected. How long this returns 1 after a motion
was detected can be adjusted with one of the small potentiometers on the
Motion Detector Bricklet, see :ref:`here
<motion_detector_bricklet_sensitivity_delay_block_time>`.

There is also a blue LED on the Bricklet that is on as long as the Bricklet is
in the "motion detected" state.
"""
function get_motion_detected(device::BrickletMotionDetector)
    return device.deviceInternal.get_motion_detected()
end

export set_status_led_config
"""
    $(SIGNATURES)

Sets the status led configuration.

By default the status LED turns on if a motion is detected and off is no motion
is detected.

You can also turn the LED permanently on/off.

.. versionadded:: 2.0.1\$nbsp;(Plugin)
"""
function set_status_led_config(device::BrickletMotionDetector, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`.

.. versionadded:: 2.0.1\$nbsp;(Plugin)
"""
function get_status_led_config(device::BrickletMotionDetector)
    return device.deviceInternal.get_status_led_config()
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
function get_identity(device::BrickletMotionDetector)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletMotionDetector, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
