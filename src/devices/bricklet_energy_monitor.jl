


export BrickletEnergyMonitorEnergyData
struct BrickletEnergyMonitorEnergyData
    voltage::Integer
    current::Integer
    energy::Integer
    real_power::Integer
    apparent_power::Integer
    reactive_power::Integer
    power_factor::Integer
    frequency::Integer
end

export BrickletEnergyMonitorWaveformLowLevel
struct BrickletEnergyMonitorWaveformLowLevel
    waveform_chunk_offset::Integer
    waveform_chunk_data::Vector{Integer}
end

export BrickletEnergyMonitorTransformerStatus
struct BrickletEnergyMonitorTransformerStatus
    voltage_transformer_connected::Bool
    current_transformer_connected::Bool
end

export BrickletEnergyMonitorTransformerCalibration
struct BrickletEnergyMonitorTransformerCalibration
    voltage_ratio::Integer
    current_ratio::Integer
    phase_shift::Integer
end

export BrickletEnergyMonitorEnergyDataCallbackConfiguration
struct BrickletEnergyMonitorEnergyDataCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
end

export BrickletEnergyMonitorSPITFPErrorCount
struct BrickletEnergyMonitorSPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletEnergyMonitorIdentity
struct BrickletEnergyMonitorIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletEnergyMonitor
"""
Measures Voltage, Current, Energy, Real/Apparent/Reactive Power, Power Factor and Frequency
"""
mutable struct BrickletEnergyMonitor <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletEnergyMonitor(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_energy_monitor")
        deviceInternal = package.BrickletEnergyMonitor(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_energy_data
"""
    $(SIGNATURES)

Returns all of the measurements that are done by the Energy Monitor Bricklet.

* Voltage RMS
* Current RMS
* Energy (integrated over time)
* Real Power
* Apparent Power
* Reactive Power
* Power Factor
* Frequency (AC Frequency of the mains voltage)

The frequency is recalculated every 6 seconds.

All other values are integrated over 10 zero-crossings of the voltage sine wave.
With a standard AC mains voltage frequency of 50Hz this results in a 5 measurements
per second (or an integration time of 200ms per measurement).

If no voltage transformer is connected, the Bricklet will use the current waveform
to calculate the frequency and it will use an integration time of
10 zero-crossings of the current waveform.
"""
function get_energy_data(device::BrickletEnergyMonitor)
    return device.deviceInternal.get_energy_data()
end

export reset_energy
"""
    $(SIGNATURES)

Sets the energy value (see :func:`Get Energy Data`) back to 0Wh.
"""
function reset_energy(device::BrickletEnergyMonitor)
    device.deviceInternal.reset_energy()
end

export get_waveform_low_level
"""
    $(SIGNATURES)

Returns a snapshot of the voltage and current waveform. The values
in the returned array alternate between voltage and current. The data from
one getter call contains 768 data points for voltage and current, which
correspond to about 3 full sine waves.

The voltage is given with a resolution of 100mV and the current is given
with a resolution of 10mA.

This data is meant to be used for a non-realtime graphical representation of
the voltage and current waveforms.
"""
function get_waveform_low_level(device::BrickletEnergyMonitor)
    return device.deviceInternal.get_waveform_low_level()
end

export get_transformer_status
"""
    $(SIGNATURES)

Returns *true* if a voltage/current transformer is connected to the Bricklet.
"""
function get_transformer_status(device::BrickletEnergyMonitor)
    return device.deviceInternal.get_transformer_status()
end

export set_transformer_calibration
"""
    $(SIGNATURES)

Sets the transformer ratio for the voltage and current transformer in 1/100 form.

Example: If your mains voltage is 230V, you use 9V voltage transformer and a
1V:30A current clamp your voltage ratio is 230/9 = 25.56 and your current ratio
is 30/1 = 30.

In this case you have to set the values 2556 and 3000 for voltage ratio and current
ratio.

The calibration is saved in non-volatile memory, you only have to set it once.

Set the phase shift to 0. It is for future use and currently not supported by the Bricklet.
"""
function set_transformer_calibration(device::BrickletEnergyMonitor, voltage_ratio, current_ratio, phase_shift)
    device.deviceInternal.set_transformer_calibration(voltage_ratio, current_ratio, phase_shift)
end

export get_transformer_calibration
"""
    $(SIGNATURES)

Returns the transformer calibration as set by :func:`Set Transformer Calibration`.
"""
function get_transformer_calibration(device::BrickletEnergyMonitor)
    return device.deviceInternal.get_transformer_calibration()
end

export calibrate_offset
"""
    $(SIGNATURES)

Calling this function will start an offset calibration. The offset calibration will
integrate the voltage and current waveform over a longer time period to find the 0
transition point in the sine wave.

The Bricklet comes with a factory-calibrated offset value, you should not have to
call this function.

If you want to re-calibrate the offset we recommend that you connect a load that
has a smooth sinusoidal voltage and current waveform. Alternatively you can also
short both inputs.

The calibration is saved in non-volatile memory, you only have to set it once.
"""
function calibrate_offset(device::BrickletEnergyMonitor)
    device.deviceInternal.calibrate_offset()
end

export set_energy_data_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Energy Data`
callback is triggered periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change within the
period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.
"""
function set_energy_data_callback_configuration(device::BrickletEnergyMonitor, period, value_has_to_change)
    device.deviceInternal.set_energy_data_callback_configuration(period, value_has_to_change)
end

export get_energy_data_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by
:func:`Set Energy Data Callback Configuration`.
"""
function get_energy_data_callback_configuration(device::BrickletEnergyMonitor)
    return device.deviceInternal.get_energy_data_callback_configuration()
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
function get_spitfp_error_count(device::BrickletEnergyMonitor)
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
function set_bootloader_mode(device::BrickletEnergyMonitor, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletEnergyMonitor)
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
function set_write_firmware_pointer(device::BrickletEnergyMonitor, pointer)
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
function write_firmware(device::BrickletEnergyMonitor, data)
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
function set_status_led_config(device::BrickletEnergyMonitor, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletEnergyMonitor)
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
function get_chip_temperature(device::BrickletEnergyMonitor)
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
function reset(device::BrickletEnergyMonitor)
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
function write_uid(device::BrickletEnergyMonitor, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletEnergyMonitor)
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
function get_identity(device::BrickletEnergyMonitor)
    return device.deviceInternal.get_identity()
end

export get_waveform
"""
Returns a snapshot of the voltage and current waveform. The values
in the returned array alternate between voltage and current. The data from
one getter call contains 768 data points for voltage and current, which
correspond to about 3 full sine waves.

The voltage is given with a resolution of 100mV and the current is given
with a resolution of 10mA.

This data is meant to be used for a non-realtime graphical representation of
the voltage and current waveforms.
"""
function get_waveform(device::BrickletEnergyMonitor)

    waveform_length = 1536

    lock(device.stream_lock) do
        ret = get_waveform_low_level(device, )

        if ret.waveform_chunk_offset == (1 << 16) - 1 # maximum chunk offset -> stream has no data
            waveform_length = 0
            waveform_out_of_sync = false
            waveform_data = ()
        else
            waveform_out_of_sync = ret.waveform_chunk_offset != 0
        end

        waveform_data = ret.waveform_chunk_data

        while !waveform_out_of_sync && length(waveform_data) < waveform_length
            ret = get_waveform_low_level(device, )
            waveform_out_of_sync = ret.waveform_chunk_offset != length(waveform_data)
            waveform_data += ret.waveform_chunk_data
        end

        if waveform_out_of_sync # discard remaining stream to bring it back in-sync
            while ret.waveform_chunk_offset + 30 < waveform_length
                ret = get_waveform_low_level(device, )
            end

            throw(TinkerforgeStreamOutOfSyncError("Waveform stream is out-of-sync"))
        end
    end

        return waveform_data[:waveform_length]
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletEnergyMonitor, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
