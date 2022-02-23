


export BrickletSoundPressureLevelDecibelCallbackConfiguration
struct BrickletSoundPressureLevelDecibelCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
    option::Char
    min::Integer
    max::Integer
end

export BrickletSoundPressureLevelSpectrumLowLevel
struct BrickletSoundPressureLevelSpectrumLowLevel
    spectrum_length::Integer
    spectrum_chunk_offset::Integer
    spectrum_chunk_data::Vector{Integer}
end

export BrickletSoundPressureLevelConfiguration
struct BrickletSoundPressureLevelConfiguration
    fft_size::Integer
    weighting::Integer
end

export BrickletSoundPressureLevelSPITFPErrorCount
struct BrickletSoundPressureLevelSPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletSoundPressureLevelIdentity
struct BrickletSoundPressureLevelIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletSoundPressureLevel
"""
Measures Sound Pressure Level in dB(A/B/C/D/Z)
"""
mutable struct BrickletSoundPressureLevel <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletSoundPressureLevel(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_sound_pressure_level")
        deviceInternal = package.BrickletSoundPressureLevel(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_decibel
"""
    $(SIGNATURES)

Returns the measured sound pressure in decibels.

The Bricklet supports the weighting standards dB(A), dB(B), dB(C), dB(D),
dB(Z) and ITU-R 468. You can configure the weighting with :func:`Set Configuration`.

By default dB(A) will be used.


If you want to get the value periodically, it is recommended to use the
:cb:`Decibel` callback. You can set the callback configuration
with :func:`Set Decibel Callback Configuration`.
"""
function get_decibel(device::BrickletSoundPressureLevel)
    return device.deviceInternal.get_decibel()
end

export set_decibel_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Decibel` callback is triggered
periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change
within the period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.

It is furthermore possible to constrain the callback with thresholds.

The `option`-parameter together with min/max sets a threshold for the :cb:`Decibel` callback.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Threshold is turned off"
 "'o'",    "Threshold is triggered when the value is *outside* the min and max values"
 "'i'",    "Threshold is triggered when the value is *inside* or equal to the min and max values"
 "'<'",    "Threshold is triggered when the value is smaller than the min value (max is ignored)"
 "'>'",    "Threshold is triggered when the value is greater than the min value (max is ignored)"

If the option is set to 'x' (threshold turned off) the callback is triggered with the fixed period.
"""
function set_decibel_callback_configuration(device::BrickletSoundPressureLevel, period, value_has_to_change, option, min, max)
    device.deviceInternal.set_decibel_callback_configuration(period, value_has_to_change, option, min, max)
end

export get_decibel_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by :func:`Set Decibel Callback Configuration`.
"""
function get_decibel_callback_configuration(device::BrickletSoundPressureLevel)
    return device.deviceInternal.get_decibel_callback_configuration()
end

export get_spectrum_low_level
"""
    $(SIGNATURES)

Returns the frequency spectrum. The length of the spectrum is between
512 (FFT size 1024) and 64 (FFT size 128). See :func:`Set Configuration`.

Each array element is one bin of the FFT. The first bin is always the
DC offset and the other bins have a size between 40Hz (FFT size 1024) and
320Hz (FFT size 128).

In sum the frequency of the spectrum always has a range from 0 to
20480Hz (the FFT is applied to samples with a frequency of 40960Hz).

The returned data is already equalized, which means that the microphone
frequency response is compensated and the weighting function is applied
(see :func:`Set Configuration` for the available weighting standards). Use
dB(Z) if you need the unaltered spectrum.

The values are not in dB form yet. If you want a proper dB scale of the
spectrum you have to apply the formula f(x) = 20*log10(max(1, x/sqrt(2)))
on each value.
"""
function get_spectrum_low_level(device::BrickletSoundPressureLevel)
    return device.deviceInternal.get_spectrum_low_level()
end

export set_spectrum_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Spectrum` callback is
triggered periodically. A value of 0 turns the callback off.

Every new measured spectrum will be send at most once. Set the period to 1 to
make sure that you get every spectrum.
"""
function set_spectrum_callback_configuration(device::BrickletSoundPressureLevel, period)
    device.deviceInternal.set_spectrum_callback_configuration(period)
end

export get_spectrum_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by
:func:`Get Spectrum Callback Configuration`.
"""
function get_spectrum_callback_configuration(device::BrickletSoundPressureLevel)
    return device.deviceInternal.get_spectrum_callback_configuration()
end

export set_configuration
"""
    $(SIGNATURES)

Sets the Sound Pressure Level Bricklet configuration.

With different FFT sizes the Bricklet has a different
amount of samples per second and the size of the FFT bins
changes. The higher the FFT size the more precise is the result
of the dB(X) calculation.

Available FFT sizes are:

* 1024: 512 bins, 10 samples per second, each bin has size 40Hz
* 512: 256 bins, 20 samples per second, each bin has size 80Hz
* 256: 128 bins, 40 samples per second, each bin has size 160Hz
* 128: 64 bins, 80 samples per second, each bin has size 320Hz

The Bricklet supports different weighting functions. You can choose
between dB(A), dB(B), dB(C), dB(D), dB(Z) and ITU-R 468.

dB(A/B/C/D) are the standard dB weighting curves. dB(A) is
often used to measure volumes at concerts etc. dB(Z) has a
flat response, no weighting is applied. ITU-R 468 is an ITU
weighting standard mostly used in the UK and Europe.
"""
function set_configuration(device::BrickletSoundPressureLevel, fft_size, weighting)
    device.deviceInternal.set_configuration(fft_size, weighting)
end

export get_configuration
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Configuration`.
"""
function get_configuration(device::BrickletSoundPressureLevel)
    return device.deviceInternal.get_configuration()
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
function get_spitfp_error_count(device::BrickletSoundPressureLevel)
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
function set_bootloader_mode(device::BrickletSoundPressureLevel, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletSoundPressureLevel)
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
function set_write_firmware_pointer(device::BrickletSoundPressureLevel, pointer)
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
function write_firmware(device::BrickletSoundPressureLevel, data)
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
function set_status_led_config(device::BrickletSoundPressureLevel, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletSoundPressureLevel)
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
function get_chip_temperature(device::BrickletSoundPressureLevel)
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
function reset(device::BrickletSoundPressureLevel)
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
function write_uid(device::BrickletSoundPressureLevel, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletSoundPressureLevel)
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
function get_identity(device::BrickletSoundPressureLevel)
    return device.deviceInternal.get_identity()
end

export get_spectrum
"""
Returns the frequency spectrum. The length of the spectrum is between
512 (FFT size 1024) and 64 (FFT size 128). See :func:`Set Configuration`.

Each array element is one bin of the FFT. The first bin is always the
DC offset and the other bins have a size between 40Hz (FFT size 1024) and
320Hz (FFT size 128).

In sum the frequency of the spectrum always has a range from 0 to
20480Hz (the FFT is applied to samples with a frequency of 40960Hz).

The returned data is already equalized, which means that the microphone
frequency response is compensated and the weighting function is applied
(see :func:`Set Configuration` for the available weighting standards). Use
dB(Z) if you need the unaltered spectrum.

The values are not in dB form yet. If you want a proper dB scale of the
spectrum you have to apply the formula f(x) = 20*log10(max(1, x/sqrt(2)))
on each value.
"""
function get_spectrum(device::BrickletSoundPressureLevel)

    lock(device.stream_lock) do
        ret = get_spectrum_low_level(device, )
            spectrum_length = ret.spectrum_length
        spectrum_out_of_sync = ret.spectrum_chunk_offset != 0

        spectrum_data = ret.spectrum_chunk_data

        while !spectrum_out_of_sync && length(spectrum_data) < spectrum_length
            ret = get_spectrum_low_level(device, )
                spectrum_length = ret.spectrum_length
            spectrum_out_of_sync = ret.spectrum_chunk_offset != length(spectrum_data)
            spectrum_data += ret.spectrum_chunk_data
        end

        if spectrum_out_of_sync # discard remaining stream to bring it back in-sync
            while ret.spectrum_chunk_offset + 30 < spectrum_length
                ret = get_spectrum_low_level(device, )
                    spectrum_length = ret.spectrum_length
            end

            throw(TinkerforgeStreamOutOfSyncError("Spectrum stream is out-of-sync"))
        end
    end

        return spectrum_data[:spectrum_length]
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletSoundPressureLevel, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
