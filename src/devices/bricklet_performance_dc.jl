


export BrickletPerformanceDCMotion
struct BrickletPerformanceDCMotion
    acceleration::Integer
    deceleration::Integer
end

export BrickletPerformanceDCPowerStatistics
struct BrickletPerformanceDCPowerStatistics
    voltage::Integer
    current::Integer
    temperature::Integer
end

export BrickletPerformanceDCGPIOConfiguration
struct BrickletPerformanceDCGPIOConfiguration
    debounce::Integer
    stop_deceleration::Integer
end

export BrickletPerformanceDCCurrentVelocityCallbackConfiguration
struct BrickletPerformanceDCCurrentVelocityCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
end

export BrickletPerformanceDCSPITFPErrorCount
struct BrickletPerformanceDCSPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletPerformanceDCIdentity
struct BrickletPerformanceDCIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletPerformanceDC
"""
Drives one brushed DC motor with up to 36V and 10A
"""
mutable struct BrickletPerformanceDC <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletPerformanceDC(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_performance_dc")
        deviceInternal = package.BrickletPerformanceDC(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export set_enabled
"""
    $(SIGNATURES)

Enables/Disables the driver chip. The driver parameters can be configured
(velocity, acceleration, etc) before it is enabled.
"""
function set_enabled(device::BrickletPerformanceDC, enabled)
    device.deviceInternal.set_enabled(enabled)
end

export get_enabled
"""
    $(SIGNATURES)

Returns *true* if the driver chip is enabled, *false* otherwise.
"""
function get_enabled(device::BrickletPerformanceDC)
    return device.deviceInternal.get_enabled()
end

export set_velocity
"""
    $(SIGNATURES)

Sets the velocity of the motor. Whereas -32767 is full speed backward,
0 is stop and 32767 is full speed forward. Depending on the
acceleration (see :func:`Set Motion`), the motor is not immediately
brought to the velocity but smoothly accelerated.

The velocity describes the duty cycle of the PWM with which the motor is
controlled, e.g. a velocity of 3277 sets a PWM with a 10% duty cycle.
You can not only control the duty cycle of the PWM but also the frequency,
see :func:`Set PWM Frequency`.
"""
function set_velocity(device::BrickletPerformanceDC, velocity)
    device.deviceInternal.set_velocity(velocity)
end

export get_velocity
"""
    $(SIGNATURES)

Returns the velocity as set by :func:`Set Velocity`.
"""
function get_velocity(device::BrickletPerformanceDC)
    return device.deviceInternal.get_velocity()
end

export get_current_velocity
"""
    $(SIGNATURES)

Returns the *current* velocity of the motor. This value is different
from :func:`Get Velocity` whenever the motor is currently accelerating
to a goal set by :func:`Set Velocity`.
"""
function get_current_velocity(device::BrickletPerformanceDC)
    return device.deviceInternal.get_current_velocity()
end

export set_motion
"""
    $(SIGNATURES)

Sets the acceleration and deceleration of the motor. It is given in *velocity/s*.
An acceleration of 10000 means, that every second the velocity is increased
by 10000 (or about 30% duty cycle).

For example: If the current velocity is 0 and you want to accelerate to a
velocity of 16000 (about 50% duty cycle) in 10 seconds, you should set
an acceleration of 1600.

If acceleration and deceleration is set to 0, there is no speed ramping, i.e. a
new velocity is immediately given to the motor.
"""
function set_motion(device::BrickletPerformanceDC, acceleration, deceleration)
    device.deviceInternal.set_motion(acceleration, deceleration)
end

export get_motion
"""
    $(SIGNATURES)

Returns the acceleration/deceleration as set by :func:`Set Motion`.
"""
function get_motion(device::BrickletPerformanceDC)
    return device.deviceInternal.get_motion()
end

export full_brake
"""
    $(SIGNATURES)

Executes an active full brake.

.. warning::
 This function is for emergency purposes,
 where an immediate brake is necessary. Depending on the current velocity and
 the strength of the motor, a full brake can be quite violent.

Call :func:`Set Velocity` with 0 if you just want to stop the motor.
"""
function full_brake(device::BrickletPerformanceDC)
    device.deviceInternal.full_brake()
end

export set_drive_mode
"""
    $(SIGNATURES)

Sets the drive mode. Possible modes are:

* 0 = Drive/Brake
* 1 = Drive/Coast

These modes are different kinds of motor controls.

In Drive/Brake mode, the motor is always either driving or braking. There
is no freewheeling. Advantages are: A more linear correlation between
PWM and velocity, more exact accelerations and the possibility to drive
with slower velocities.

In Drive/Coast mode, the motor is always either driving or freewheeling.
Advantages are: Less current consumption and less demands on the motor and
driver chip.
"""
function set_drive_mode(device::BrickletPerformanceDC, mode)
    device.deviceInternal.set_drive_mode(mode)
end

export get_drive_mode
"""
    $(SIGNATURES)

Returns the drive mode, as set by :func:`Set Drive Mode`.
"""
function get_drive_mode(device::BrickletPerformanceDC)
    return device.deviceInternal.get_drive_mode()
end

export set_pwm_frequency
"""
    $(SIGNATURES)

Sets the frequency of the PWM with which the motor is driven.
Often a high frequency
is less noisy and the motor runs smoother. However, with a low frequency
there are less switches and therefore fewer switching losses. Also with
most motors lower frequencies enable higher torque.

If you have no idea what all this means, just ignore this function and use
the default frequency, it will very likely work fine.
"""
function set_pwm_frequency(device::BrickletPerformanceDC, frequency)
    device.deviceInternal.set_pwm_frequency(frequency)
end

export get_pwm_frequency
"""
    $(SIGNATURES)

Returns the PWM frequency as set by :func:`Set PWM Frequency`.
"""
function get_pwm_frequency(device::BrickletPerformanceDC)
    return device.deviceInternal.get_pwm_frequency()
end

export get_power_statistics
"""
    $(SIGNATURES)

Returns input voltage, current usage and temperature of the driver.
"""
function get_power_statistics(device::BrickletPerformanceDC)
    return device.deviceInternal.get_power_statistics()
end

export set_thermal_shutdown
"""
    $(SIGNATURES)

Sets a temperature threshold that is used for thermal shutdown.

Additionally to this user defined threshold the driver chip will shut down at a
temperature of 150°C.

If a thermal shutdown is triggered the driver is disabled and has to be
explicitly re-enabled with :func:`Set Enabled`.
"""
function set_thermal_shutdown(device::BrickletPerformanceDC, temperature)
    device.deviceInternal.set_thermal_shutdown(temperature)
end

export get_thermal_shutdown
"""
    $(SIGNATURES)

Returns the thermal shutdown temperature as set by :func:`Set Thermal Shutdown`.
"""
function get_thermal_shutdown(device::BrickletPerformanceDC)
    return device.deviceInternal.get_thermal_shutdown()
end

export set_gpio_configuration
"""
    $(SIGNATURES)

Sets the GPIO configuration for the given channel.
You can configure a debounce and the deceleration that is used if the action is
configured as ``normal stop``. See :func:`Set GPIO Action`.
"""
function set_gpio_configuration(device::BrickletPerformanceDC, channel, debounce, stop_deceleration)
    device.deviceInternal.set_gpio_configuration(channel, debounce, stop_deceleration)
end

export get_gpio_configuration
"""
    $(SIGNATURES)

Returns the GPIO configuration for a channel as set by :func:`Set GPIO Configuration`.
"""
function get_gpio_configuration(device::BrickletPerformanceDC, channel)
    return device.deviceInternal.get_gpio_configuration(channel)
end

export set_gpio_action
"""
    $(SIGNATURES)

Sets the GPIO action for the given channel.

The action can be a normal stop, a full brake or a callback. Each for a rising
edge or falling edge. The actions are a bitmask they can be used at the same time.
You can for example trigger a full brake and a callback at the same time or for
rising and falling edge.

The deceleration speed for the normal stop can be configured with
:func:`Set GPIO Configuration`.
"""
function set_gpio_action(device::BrickletPerformanceDC, channel, action)
    device.deviceInternal.set_gpio_action(channel, action)
end

export get_gpio_action
"""
    $(SIGNATURES)

Returns the GPIO action for a channel as set by :func:`Set GPIO Action`.
"""
function get_gpio_action(device::BrickletPerformanceDC, channel)
    return device.deviceInternal.get_gpio_action(channel)
end

export get_gpio_state
"""
    $(SIGNATURES)

Returns the GPIO state for both channels. True if the state is ``high`` and
false if the state is ``low``.
"""
function get_gpio_state(device::BrickletPerformanceDC)
    return device.deviceInternal.get_gpio_state()
end

export set_error_led_config
"""
    $(SIGNATURES)

Configures the error LED to be either turned off, turned on, blink in
heartbeat mode or show an error.

If the LED is configured to show errors it has three different states:

* Off: No error present.
* 1s interval blinking: Input voltage too low (below 6V).
* 250ms interval blinking: Overtemperature or overcurrent.
"""
function set_error_led_config(device::BrickletPerformanceDC, config)
    device.deviceInternal.set_error_led_config(config)
end

export get_error_led_config
"""
    $(SIGNATURES)

Returns the LED configuration as set by :func:`Set Error LED Config`
"""
function get_error_led_config(device::BrickletPerformanceDC)
    return device.deviceInternal.get_error_led_config()
end

export set_cw_led_config
"""
    $(SIGNATURES)

Configures the CW LED to be either turned off, turned on, blink in
heartbeat mode or if the motor turn clockwise.
"""
function set_cw_led_config(device::BrickletPerformanceDC, config)
    device.deviceInternal.set_cw_led_config(config)
end

export get_cw_led_config
"""
    $(SIGNATURES)

Returns the LED configuration as set by :func:`Set CW LED Config`
"""
function get_cw_led_config(device::BrickletPerformanceDC)
    return device.deviceInternal.get_cw_led_config()
end

export set_ccw_led_config
"""
    $(SIGNATURES)

Configures the CCW LED to be either turned off, turned on, blink in
heartbeat mode or if the motor turn counter-clockwise.
"""
function set_ccw_led_config(device::BrickletPerformanceDC, config)
    device.deviceInternal.set_ccw_led_config(config)
end

export get_ccw_led_config
"""
    $(SIGNATURES)

Returns the LED configuration as set by :func:`Set CCW LED Config`
"""
function get_ccw_led_config(device::BrickletPerformanceDC)
    return device.deviceInternal.get_ccw_led_config()
end

export set_gpio_led_config
"""
    $(SIGNATURES)

Configures the GPIO LED to be either turned off, turned on, blink in
heartbeat mode or the GPIO state.

The GPIO LED can be configured for both channels.
"""
function set_gpio_led_config(device::BrickletPerformanceDC, channel, config)
    device.deviceInternal.set_gpio_led_config(channel, config)
end

export get_gpio_led_config
"""
    $(SIGNATURES)

Returns the LED configuration as set by :func:`Set GPIO LED Config`
"""
function get_gpio_led_config(device::BrickletPerformanceDC, channel)
    return device.deviceInternal.get_gpio_led_config(channel)
end

export set_emergency_shutdown_callback_configuration
"""
    $(SIGNATURES)

Enable/Disable :cb:`Emergency Shutdown` callback.
"""
function set_emergency_shutdown_callback_configuration(device::BrickletPerformanceDC, enabled)
    device.deviceInternal.set_emergency_shutdown_callback_configuration(enabled)
end

export get_emergency_shutdown_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by
:func:`Set Emergency Shutdown Callback Configuration`.
"""
function get_emergency_shutdown_callback_configuration(device::BrickletPerformanceDC)
    return device.deviceInternal.get_emergency_shutdown_callback_configuration()
end

export set_velocity_reached_callback_configuration
"""
    $(SIGNATURES)

Enable/Disable :cb:`Velocity Reached` callback.
"""
function set_velocity_reached_callback_configuration(device::BrickletPerformanceDC, enabled)
    device.deviceInternal.set_velocity_reached_callback_configuration(enabled)
end

export get_velocity_reached_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by
:func:`Set Velocity Reached Callback Configuration`.
"""
function get_velocity_reached_callback_configuration(device::BrickletPerformanceDC)
    return device.deviceInternal.get_velocity_reached_callback_configuration()
end

export set_current_velocity_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Current Velocity`
callback is triggered periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change within the
period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.
"""
function set_current_velocity_callback_configuration(device::BrickletPerformanceDC, period, value_has_to_change)
    device.deviceInternal.set_current_velocity_callback_configuration(period, value_has_to_change)
end

export get_current_velocity_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by
:func:`Set Current Velocity Callback Configuration`.
"""
function get_current_velocity_callback_configuration(device::BrickletPerformanceDC)
    return device.deviceInternal.get_current_velocity_callback_configuration()
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
function get_spitfp_error_count(device::BrickletPerformanceDC)
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
function set_bootloader_mode(device::BrickletPerformanceDC, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletPerformanceDC)
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
function set_write_firmware_pointer(device::BrickletPerformanceDC, pointer)
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
function write_firmware(device::BrickletPerformanceDC, data)
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
function set_status_led_config(device::BrickletPerformanceDC, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletPerformanceDC)
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
function get_chip_temperature(device::BrickletPerformanceDC)
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
function reset(device::BrickletPerformanceDC)
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
function write_uid(device::BrickletPerformanceDC, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletPerformanceDC)
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
function get_identity(device::BrickletPerformanceDC)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletPerformanceDC, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
