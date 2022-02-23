


export BrickIMUAcceleration
struct BrickIMUAcceleration
    x::Integer
    y::Integer
    z::Integer
end

export BrickIMUMagneticField
struct BrickIMUMagneticField
    x::Integer
    y::Integer
    z::Integer
end

export BrickIMUAngularVelocity
struct BrickIMUAngularVelocity
    x::Integer
    y::Integer
    z::Integer
end

export BrickIMUAllData
struct BrickIMUAllData
    acc_x::Integer
    acc_y::Integer
    acc_z::Integer
    mag_x::Integer
    mag_y::Integer
    mag_z::Integer
    ang_x::Integer
    ang_y::Integer
    ang_z::Integer
    temperature::Integer
end

export BrickIMUOrientation
struct BrickIMUOrientation
    roll::Integer
    pitch::Integer
    yaw::Integer
end

export BrickIMUQuaternion
struct BrickIMUQuaternion
    x::Real
    y::Real
    z::Real
    w::Real
end

export BrickIMUSPITFPBaudrateConfig
struct BrickIMUSPITFPBaudrateConfig
    enable_dynamic_baudrate::Bool
    minimum_dynamic_baudrate::Integer
end

export BrickIMUSPITFPErrorCount
struct BrickIMUSPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickIMUProtocol1BrickletName
struct BrickIMUProtocol1BrickletName
    protocol_version::Integer
    firmware_version::Vector{Integer}
    name::String
end

export BrickIMUIdentity
struct BrickIMUIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickIMU
"""
Full fledged AHRS with 9 degrees of freedom
"""
mutable struct BrickIMU <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickIMU(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.brick_imu")
        deviceInternal = package.BrickIMU(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_acceleration
"""
    $(SIGNATURES)

Returns the calibrated acceleration from the accelerometer for the
x, y and z axis.

If you want to get the acceleration periodically, it is recommended
to use the :cb:`Acceleration` callback and set the period with
:func:`Set Acceleration Period`.
"""
function get_acceleration(device::BrickIMU)
    return device.deviceInternal.get_acceleration()
end

export get_magnetic_field
"""
    $(SIGNATURES)

Returns the calibrated magnetic field from the magnetometer for the
x, y and z axis.

If you want to get the magnetic field periodically, it is recommended
to use the :cb:`Magnetic Field` callback and set the period with
:func:`Set Magnetic Field Period`.
"""
function get_magnetic_field(device::BrickIMU)
    return device.deviceInternal.get_magnetic_field()
end

export get_angular_velocity
"""
    $(SIGNATURES)

Returns the calibrated angular velocity from the gyroscope for the
x, y and z axis in °/14.375s (you have to divide by 14.375 to
get the value in °/s).

If you want to get the angular velocity periodically, it is recommended
to use the :cb:`Angular Velocity` callback and set the period with
:func:`Set Angular Velocity Period`.
"""
function get_angular_velocity(device::BrickIMU)
    return device.deviceInternal.get_angular_velocity()
end

export get_all_data
"""
    $(SIGNATURES)

Returns the data from :func:`Get Acceleration`, :func:`Get Magnetic Field`
and :func:`Get Angular Velocity` as well as the temperature of the IMU Brick.

If you want to get the data periodically, it is recommended
to use the :cb:`All Data` callback and set the period with
:func:`Set All Data Period`.
"""
function get_all_data(device::BrickIMU)
    return device.deviceInternal.get_all_data()
end

export get_orientation
"""
    $(SIGNATURES)

Returns the current orientation (roll, pitch, yaw) of the IMU Brick as Euler
angles. Note that Euler angles always experience a
`gimbal lock <https://en.wikipedia.org/wiki/Gimbal_lock>`__.

We recommend that you use quaternions instead.

The order to sequence in which the orientation values should be applied is
roll, yaw, pitch.

If you want to get the orientation periodically, it is recommended
to use the :cb:`Orientation` callback and set the period with
:func:`Set Orientation Period`.
"""
function get_orientation(device::BrickIMU)
    return device.deviceInternal.get_orientation()
end

export get_quaternion
"""
    $(SIGNATURES)

Returns the current orientation (x, y, z, w) of the IMU as
`quaternions <https://en.wikipedia.org/wiki/Quaternions_and_spatial_rotation>`__.

You can go from quaternions to Euler angles with the following formula::

 xAngle = atan2(2*y*w - 2*x*z, 1 - 2*y*y - 2*z*z)
 yAngle = atan2(2*x*w - 2*y*z, 1 - 2*x*x - 2*z*z)
 zAngle =  asin(2*x*y + 2*z*w)

This process is not reversible, because of the
`gimbal lock <https://en.wikipedia.org/wiki/Gimbal_lock>`__.

It is also possible to calculate independent angles. You can calculate
yaw, pitch and roll in a right-handed vehicle coordinate system according to
DIN70000 with::

 yaw   =  atan2(2*x*y + 2*w*z, w*w + x*x - y*y - z*z)
 pitch = -asin(2*w*y - 2*x*z)
 roll  = -atan2(2*y*z + 2*w*x, -w*w + x*x + y*y - z*z))

Converting the quaternions to an OpenGL transformation matrix is
possible with the following formula::

 matrix = [[1 - 2*(y*y + z*z),     2*(x*y - w*z),     2*(x*z + w*y), 0],
           [    2*(x*y + w*z), 1 - 2*(x*x + z*z),     2*(y*z - w*x), 0],
           [    2*(x*z - w*y),     2*(y*z + w*x), 1 - 2*(x*x + y*y), 0],
           [                0,                 0,                 0, 1]]

If you want to get the quaternions periodically, it is recommended
to use the :cb:`Quaternion` callback and set the period with
:func:`Set Quaternion Period`.
"""
function get_quaternion(device::BrickIMU)
    return device.deviceInternal.get_quaternion()
end

export get_imu_temperature
"""
    $(SIGNATURES)

Returns the temperature of the IMU Brick.
"""
function get_imu_temperature(device::BrickIMU)
    return device.deviceInternal.get_imu_temperature()
end

export leds_on
"""
    $(SIGNATURES)

Turns the orientation and direction LEDs of the IMU Brick on.
"""
function leds_on(device::BrickIMU)
    device.deviceInternal.leds_on()
end

export leds_off
"""
    $(SIGNATURES)

Turns the orientation and direction LEDs of the IMU Brick off.
"""
function leds_off(device::BrickIMU)
    device.deviceInternal.leds_off()
end

export are_leds_on
"""
    $(SIGNATURES)

Returns *true* if the orientation and direction LEDs of the IMU Brick
are on, *false* otherwise.
"""
function are_leds_on(device::BrickIMU)
    return device.deviceInternal.are_leds_on()
end

export set_acceleration_range
"""
    $(SIGNATURES)

Not implemented yet.
"""
function set_acceleration_range(device::BrickIMU, range)
    device.deviceInternal.set_acceleration_range(range)
end

export get_acceleration_range
"""
    $(SIGNATURES)

Not implemented yet.
"""
function get_acceleration_range(device::BrickIMU)
    return device.deviceInternal.get_acceleration_range()
end

export set_magnetometer_range
"""
    $(SIGNATURES)

Not implemented yet.
"""
function set_magnetometer_range(device::BrickIMU, range)
    device.deviceInternal.set_magnetometer_range(range)
end

export get_magnetometer_range
"""
    $(SIGNATURES)

Not implemented yet.
"""
function get_magnetometer_range(device::BrickIMU)
    return device.deviceInternal.get_magnetometer_range()
end

export set_convergence_speed
"""
    $(SIGNATURES)

Sets the convergence speed of the IMU Brick. The convergence speed
determines how the different sensor measurements are fused.

If the orientation of the IMU Brick is off by 10° and the convergence speed is
set to 20°/s, it will take 0.5s until the orientation is corrected. However,
if the correct orientation is reached and the convergence speed is too high,
the orientation will fluctuate with the fluctuations of the accelerometer and
the magnetometer.

If you set the convergence speed to 0, practically only the gyroscope is used
to calculate the orientation. This gives very smooth movements, but errors of the
gyroscope will not be corrected. If you set the convergence speed to something
above 500, practically only the magnetometer and the accelerometer are used to
calculate the orientation. In this case the movements are abrupt and the values
will fluctuate, but there won't be any errors that accumulate over time.

In an application with high angular velocities, we recommend a high convergence
speed, so the errors of the gyroscope can be corrected fast. In applications with
only slow movements we recommend a low convergence speed. You can change the
convergence speed on the fly. So it is possible (and recommended) to increase
the convergence speed before an abrupt movement and decrease it afterwards
again.

You might want to play around with the convergence speed in the Brick Viewer to
get a feeling for a good value for your application.
"""
function set_convergence_speed(device::BrickIMU, speed)
    device.deviceInternal.set_convergence_speed(speed)
end

export get_convergence_speed
"""
    $(SIGNATURES)

Returns the convergence speed as set by :func:`Set Convergence Speed`.
"""
function get_convergence_speed(device::BrickIMU)
    return device.deviceInternal.get_convergence_speed()
end

export set_calibration
"""
    $(SIGNATURES)

There are several different types that can be calibrated:

.. csv-table::
 :header: "Type", "Description", "Values"
 :widths: 10, 30, 110

 "0",    "Accelerometer Gain", "``[mul x, mul y, mul z, div x, div y, div z, 0, 0, 0, 0]``"
 "1",    "Accelerometer Bias", "``[bias x, bias y, bias z, 0, 0, 0, 0, 0, 0, 0]``"
 "2",    "Magnetometer Gain",  "``[mul x, mul y, mul z, div x, div y, div z, 0, 0, 0, 0]``"
 "3",    "Magnetometer Bias",  "``[bias x, bias y, bias z, 0, 0, 0, 0, 0, 0, 0]``"
 "4",    "Gyroscope Gain",     "``[mul x, mul y, mul z, div x, div y, div z, 0, 0, 0, 0]``"
 "5",    "Gyroscope Bias",     "``[bias xl, bias yl, bias zl, temp l, bias xh, bias yh, bias zh, temp h, 0, 0]``"

The calibration via gain and bias is done with the following formula::

 new_value = (bias + orig_value) * gain_mul / gain_div

If you really want to write your own calibration software, please keep
in mind that you first have to undo the old calibration (set bias to 0 and
gain to 1/1) and that you have to average over several thousand values
to obtain a usable result in the end.

The gyroscope bias is highly dependent on the temperature, so you have to
calibrate the bias two times with different temperatures. The values ``xl``,
``yl``, ``zl`` and ``temp l`` are the bias for ``x``, ``y``, ``z`` and the
corresponding temperature for a low temperature. The values ``xh``, ``yh``,
``zh`` and ``temp h`` are the same for a high temperatures. The temperature
difference should be at least 5°C. If you have a temperature where the
IMU Brick is mostly used, you should use this temperature for one of the
sampling points.

.. note::
 We highly recommend that you use the Brick Viewer to calibrate your
 IMU Brick.
"""
function set_calibration(device::BrickIMU, typ, data)
    device.deviceInternal.set_calibration(typ, data)
end

export get_calibration
"""
    $(SIGNATURES)

Returns the calibration for a given type as set by :func:`Set Calibration`.
"""
function get_calibration(device::BrickIMU, typ)
    return device.deviceInternal.get_calibration(typ)
end

export set_acceleration_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Acceleration` callback is triggered
periodically. A value of 0 turns the callback off.
"""
function set_acceleration_period(device::BrickIMU, period)
    device.deviceInternal.set_acceleration_period(period)
end

export get_acceleration_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Acceleration Period`.
"""
function get_acceleration_period(device::BrickIMU)
    return device.deviceInternal.get_acceleration_period()
end

export set_magnetic_field_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Magnetic Field` callback is
triggered periodically. A value of 0 turns the callback off.
"""
function set_magnetic_field_period(device::BrickIMU, period)
    device.deviceInternal.set_magnetic_field_period(period)
end

export get_magnetic_field_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Magnetic Field Period`.
"""
function get_magnetic_field_period(device::BrickIMU)
    return device.deviceInternal.get_magnetic_field_period()
end

export set_angular_velocity_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Angular Velocity` callback is
triggered periodically. A value of 0 turns the callback off.
"""
function set_angular_velocity_period(device::BrickIMU, period)
    device.deviceInternal.set_angular_velocity_period(period)
end

export get_angular_velocity_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Angular Velocity Period`.
"""
function get_angular_velocity_period(device::BrickIMU)
    return device.deviceInternal.get_angular_velocity_period()
end

export set_all_data_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`All Data` callback is triggered
periodically. A value of 0 turns the callback off.
"""
function set_all_data_period(device::BrickIMU, period)
    device.deviceInternal.set_all_data_period(period)
end

export get_all_data_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set All Data Period`.
"""
function get_all_data_period(device::BrickIMU)
    return device.deviceInternal.get_all_data_period()
end

export set_orientation_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Orientation` callback is triggered
periodically. A value of 0 turns the callback off.
"""
function set_orientation_period(device::BrickIMU, period)
    device.deviceInternal.set_orientation_period(period)
end

export get_orientation_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Orientation Period`.
"""
function get_orientation_period(device::BrickIMU)
    return device.deviceInternal.get_orientation_period()
end

export set_quaternion_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Quaternion` callback is triggered
periodically. A value of 0 turns the callback off.
"""
function set_quaternion_period(device::BrickIMU, period)
    device.deviceInternal.set_quaternion_period(period)
end

export get_quaternion_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Quaternion Period`.
"""
function get_quaternion_period(device::BrickIMU)
    return device.deviceInternal.get_quaternion_period()
end

export orientation_calculation_on
"""
    $(SIGNATURES)

Turns the orientation calculation of the IMU Brick on.

As default the calculation is on.

.. versionadded:: 2.0.2\$nbsp;(Firmware)
"""
function orientation_calculation_on(device::BrickIMU)
    device.deviceInternal.orientation_calculation_on()
end

export orientation_calculation_off
"""
    $(SIGNATURES)

Turns the orientation calculation of the IMU Brick off.

If the calculation is off, :func:`Get Orientation` will return
the last calculated value until the calculation is turned on again.

The trigonometric functions that are needed to calculate the orientation
are very expensive. We recommend to turn the orientation calculation
off if the orientation is not needed, to free calculation time for the
sensor fusion algorithm.

As default the calculation is on.

.. versionadded:: 2.0.2\$nbsp;(Firmware)
"""
function orientation_calculation_off(device::BrickIMU)
    device.deviceInternal.orientation_calculation_off()
end

export is_orientation_calculation_on
"""
    $(SIGNATURES)

Returns *true* if the orientation calculation of the IMU Brick
is on, *false* otherwise.

.. versionadded:: 2.0.2\$nbsp;(Firmware)
"""
function is_orientation_calculation_on(device::BrickIMU)
    return device.deviceInternal.is_orientation_calculation_on()
end

export set_spitfp_baudrate_config
"""
    $(SIGNATURES)

The SPITF protocol can be used with a dynamic baudrate. If the dynamic baudrate is
enabled, the Brick will try to adapt the baudrate for the communication
between Bricks and Bricklets according to the amount of data that is transferred.

The baudrate will be increased exponentially if lots of data is sent/received and
decreased linearly if little data is sent/received.

This lowers the baudrate in applications where little data is transferred (e.g.
a weather station) and increases the robustness. If there is lots of data to transfer
(e.g. Thermal Imaging Bricklet) it automatically increases the baudrate as needed.

In cases where some data has to transferred as fast as possible every few seconds
(e.g. RS485 Bricklet with a high baudrate but small payload) you may want to turn
the dynamic baudrate off to get the highest possible performance.

The maximum value of the baudrate can be set per port with the function
:func:`Set SPITFP Baudrate`. If the dynamic baudrate is disabled, the baudrate
as set by :func:`Set SPITFP Baudrate` will be used statically.

.. versionadded:: 2.3.5\$nbsp;(Firmware)
"""
function set_spitfp_baudrate_config(device::BrickIMU, enable_dynamic_baudrate, minimum_dynamic_baudrate)
    device.deviceInternal.set_spitfp_baudrate_config(enable_dynamic_baudrate, minimum_dynamic_baudrate)
end

export get_spitfp_baudrate_config
"""
    $(SIGNATURES)

Returns the baudrate config, see :func:`Set SPITFP Baudrate Config`.

.. versionadded:: 2.3.5\$nbsp;(Firmware)
"""
function get_spitfp_baudrate_config(device::BrickIMU)
    return device.deviceInternal.get_spitfp_baudrate_config()
end

export get_send_timeout_count
"""
    $(SIGNATURES)

Returns the timeout count for the different communication methods.

The methods 0-2 are available for all Bricks, 3-7 only for Master Bricks.

This function is mostly used for debugging during development, in normal operation
the counters should nearly always stay at 0.

.. versionadded:: 2.3.3\$nbsp;(Firmware)
"""
function get_send_timeout_count(device::BrickIMU, communication_method)
    return device.deviceInternal.get_send_timeout_count(communication_method)
end

export set_spitfp_baudrate
"""
    $(SIGNATURES)

Sets the baudrate for a specific Bricklet port.

If you want to increase the throughput of Bricklets you can increase
the baudrate. If you get a high error count because of high
interference (see :func:`Get SPITFP Error Count`) you can decrease the
baudrate.

If the dynamic baudrate feature is enabled, the baudrate set by this
function corresponds to the maximum baudrate (see :func:`Set SPITFP Baudrate Config`).

Regulatory testing is done with the default baudrate. If CE compatibility
or similar is necessary in your applications we recommend to not change
the baudrate.

.. versionadded:: 2.3.3\$nbsp;(Firmware)
"""
function set_spitfp_baudrate(device::BrickIMU, bricklet_port, baudrate)
    device.deviceInternal.set_spitfp_baudrate(bricklet_port, baudrate)
end

export get_spitfp_baudrate
"""
    $(SIGNATURES)

Returns the baudrate for a given Bricklet port, see :func:`Set SPITFP Baudrate`.

.. versionadded:: 2.3.3\$nbsp;(Firmware)
"""
function get_spitfp_baudrate(device::BrickIMU, bricklet_port)
    return device.deviceInternal.get_spitfp_baudrate(bricklet_port)
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

The errors counts are for errors that occur on the Brick side. All
Bricklets have a similar function that returns the errors on the Bricklet side.

.. versionadded:: 2.3.3\$nbsp;(Firmware)
"""
function get_spitfp_error_count(device::BrickIMU, bricklet_port)
    return device.deviceInternal.get_spitfp_error_count(bricklet_port)
end

export enable_status_led
"""
    $(SIGNATURES)

Enables the status LED.

The status LED is the blue LED next to the USB connector. If enabled is is
on and it flickers if data is transfered. If disabled it is always off.

The default state is enabled.

.. versionadded:: 2.3.1\$nbsp;(Firmware)
"""
function enable_status_led(device::BrickIMU)
    device.deviceInternal.enable_status_led()
end

export disable_status_led
"""
    $(SIGNATURES)

Disables the status LED.

The status LED is the blue LED next to the USB connector. If enabled is is
on and it flickers if data is transfered. If disabled it is always off.

The default state is enabled.

.. versionadded:: 2.3.1\$nbsp;(Firmware)
"""
function disable_status_led(device::BrickIMU)
    device.deviceInternal.disable_status_led()
end

export is_status_led_enabled
"""
    $(SIGNATURES)

Returns *true* if the status LED is enabled, *false* otherwise.

.. versionadded:: 2.3.1\$nbsp;(Firmware)
"""
function is_status_led_enabled(device::BrickIMU)
    return device.deviceInternal.is_status_led_enabled()
end

export get_protocol1_bricklet_name
"""
    $(SIGNATURES)

Returns the firmware and protocol version and the name of the Bricklet for a
given port.

This functions sole purpose is to allow automatic flashing of v1.x.y Bricklet
plugins.
"""
function get_protocol1_bricklet_name(device::BrickIMU, port)
    return device.deviceInternal.get_protocol1_bricklet_name(port)
end

export get_chip_temperature
"""
    $(SIGNATURES)

Returns the temperature as measured inside the microcontroller. The
value returned is not the ambient temperature!

The temperature is only proportional to the real temperature and it has an
accuracy of ±15%. Practically it is only useful as an indicator for
temperature changes.
"""
function get_chip_temperature(device::BrickIMU)
    return device.deviceInternal.get_chip_temperature()
end

export reset
"""
    $(SIGNATURES)

Calling this function will reset the Brick. Calling this function
on a Brick inside of a stack will reset the whole stack.

After a reset you have to create new device objects,
calling functions on the existing ones will result in
undefined behavior!
"""
function reset(device::BrickIMU)
    device.deviceInternal.reset()
end

export write_bricklet_plugin
"""
    $(SIGNATURES)

Writes 32 bytes of firmware to the bricklet attached at the given port.
The bytes are written to the position offset * 32.

This function is used by Brick Viewer during flashing. It should not be
necessary to call it in a normal user program.
"""
function write_bricklet_plugin(device::BrickIMU, port, offset, chunk)
    device.deviceInternal.write_bricklet_plugin(port, offset, chunk)
end

export read_bricklet_plugin
"""
    $(SIGNATURES)

Reads 32 bytes of firmware from the bricklet attached at the given port.
The bytes are read starting at the position offset * 32.

This function is used by Brick Viewer during flashing. It should not be
necessary to call it in a normal user program.
"""
function read_bricklet_plugin(device::BrickIMU, port, offset)
    return device.deviceInternal.read_bricklet_plugin(port, offset)
end

export get_identity
"""
    $(SIGNATURES)

Returns the UID, the UID where the Brick is connected to,
the position, the hardware and firmware version as well as the
device identifier.

The position is the position in the stack from '0' (bottom) to '8' (top).

The device identifier numbers can be found :ref:`here <device_identifier>`.
|device_identifier_constant|
"""
function get_identity(device::BrickIMU)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickIMU, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
