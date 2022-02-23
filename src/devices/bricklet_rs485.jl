


export BrickletRS485ReadLowLevel
struct BrickletRS485ReadLowLevel
    message_length::Integer
    message_chunk_offset::Integer
    message_chunk_data::Vector{Char}
end

export BrickletRS485RS485Configuration
struct BrickletRS485RS485Configuration
    baudrate::Integer
    parity::Integer
    stopbits::Integer
    wordlength::Integer
    duplex::Integer
end

export BrickletRS485ModbusConfiguration
struct BrickletRS485ModbusConfiguration
    slave_address::Integer
    master_request_timeout::Integer
end

export BrickletRS485BufferConfig
struct BrickletRS485BufferConfig
    send_buffer_size::Integer
    receive_buffer_size::Integer
end

export BrickletRS485BufferStatus
struct BrickletRS485BufferStatus
    send_buffer_used::Integer
    receive_buffer_used::Integer
end

export BrickletRS485ErrorCount
struct BrickletRS485ErrorCount
    overrun_error_count::Integer
    parity_error_count::Integer
end

export BrickletRS485ModbusCommonErrorCount
struct BrickletRS485ModbusCommonErrorCount
    timeout_error_count::Integer
    checksum_error_count::Integer
    frame_too_big_error_count::Integer
    illegal_function_error_count::Integer
    illegal_data_address_error_count::Integer
    illegal_data_value_error_count::Integer
    slave_device_failure_error_count::Integer
end

export BrickletRS485SPITFPErrorCount
struct BrickletRS485SPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletRS485Identity
struct BrickletRS485Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletRS485
"""
Communicates with RS485/Modbus devices with full- or half-duplex
"""
mutable struct BrickletRS485 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletRS485(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_rs485")
        deviceInternal = package.BrickletRS485(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export write_low_level
"""
    $(SIGNATURES)

Writes characters to the RS485 interface. The characters can be binary data,
ASCII or similar is not necessary.

The return value is the number of characters that were written.

See :func:`Set RS485 Configuration` for configuration possibilities
regarding baudrate, parity and so on.
"""
function write_low_level(device::BrickletRS485, message_length, message_chunk_offset, message_chunk_data)
    return device.deviceInternal.write_low_level(message_length, message_chunk_offset, message_chunk_data)
end

export read_low_level
"""
    $(SIGNATURES)

Returns up to *length* characters from receive buffer.

Instead of polling with this function, you can also use
callbacks. But note that this function will return available
data only when the read callback is disabled.
See :func:`Enable Read Callback` and :cb:`Read` callback.
"""
function read_low_level(device::BrickletRS485, length)
    return device.deviceInternal.read_low_level(length)
end

export enable_read_callback
"""
    $(SIGNATURES)

Enables the :cb:`Read` callback. This will disable the :cb:`Frame Readable` callback.

By default the callback is disabled.
"""
function enable_read_callback(device::BrickletRS485)
    device.deviceInternal.enable_read_callback()
end

export disable_read_callback
"""
    $(SIGNATURES)

Disables the :cb:`Read` callback.

By default the callback is disabled.
"""
function disable_read_callback(device::BrickletRS485)
    device.deviceInternal.disable_read_callback()
end

export is_read_callback_enabled
"""
    $(SIGNATURES)

Returns *true* if the :cb:`Read` callback is enabled,
*false* otherwise.
"""
function is_read_callback_enabled(device::BrickletRS485)
    return device.deviceInternal.is_read_callback_enabled()
end

export set_rs485_configuration
"""
    $(SIGNATURES)

Sets the configuration for the RS485 communication.
"""
function set_rs485_configuration(device::BrickletRS485, baudrate, parity, stopbits, wordlength, duplex)
    device.deviceInternal.set_rs485_configuration(baudrate, parity, stopbits, wordlength, duplex)
end

export get_rs485_configuration
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set RS485 Configuration`.
"""
function get_rs485_configuration(device::BrickletRS485)
    return device.deviceInternal.get_rs485_configuration()
end

export set_modbus_configuration
"""
    $(SIGNATURES)

Sets the configuration for the RS485 Modbus communication. Available options:

* Slave Address: Address to be used as the Modbus slave address in Modbus slave mode. Valid Modbus slave address range is 1 to 247.
* Master Request Timeout: Specifies how long the master should wait for a response from a slave when in Modbus master mode.
"""
function set_modbus_configuration(device::BrickletRS485, slave_address, master_request_timeout)
    device.deviceInternal.set_modbus_configuration(slave_address, master_request_timeout)
end

export get_modbus_configuration
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Modbus Configuration`.
"""
function get_modbus_configuration(device::BrickletRS485)
    return device.deviceInternal.get_modbus_configuration()
end

export set_mode
"""
    $(SIGNATURES)

Sets the mode of the Bricklet in which it operates. Available options are

* RS485,
* Modbus Master RTU and
* Modbus Slave RTU.
"""
function set_mode(device::BrickletRS485, mode)
    device.deviceInternal.set_mode(mode)
end

export get_mode
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Mode`.
"""
function get_mode(device::BrickletRS485)
    return device.deviceInternal.get_mode()
end

export set_communication_led_config
"""
    $(SIGNATURES)

Sets the communication LED configuration. By default the LED shows RS485
communication traffic by flickering.

You can also turn the LED permanently on/off or show a heartbeat.

If the Bricklet is in bootloader mode, the LED is off.
"""
function set_communication_led_config(device::BrickletRS485, config)
    device.deviceInternal.set_communication_led_config(config)
end

export get_communication_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Communication LED Config`
"""
function get_communication_led_config(device::BrickletRS485)
    return device.deviceInternal.get_communication_led_config()
end

export set_error_led_config
"""
    $(SIGNATURES)

Sets the error LED configuration.

By default the error LED turns on if there is any error (see :cb:`Error Count`
callback). If you call this function with the SHOW ERROR option again, the LED
will turn off until the next error occurs.

You can also turn the LED permanently on/off or show a heartbeat.

If the Bricklet is in bootloader mode, the LED is off.
"""
function set_error_led_config(device::BrickletRS485, config)
    device.deviceInternal.set_error_led_config(config)
end

export get_error_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Error LED Config`.
"""
function get_error_led_config(device::BrickletRS485)
    return device.deviceInternal.get_error_led_config()
end

export set_buffer_config
"""
    $(SIGNATURES)

Sets the send and receive buffer size in byte. In sum there is
10240 byte (10KiB) buffer available and the minimum buffer size
is 1024 byte (1KiB) for both.

The current buffer content is lost if this function is called.

The send buffer holds data that was given by :func:`Write` and
could not be written yet. The receive buffer holds data that is
received through RS485 but could not yet be send to the
user, either by :func:`Read` or through :cb:`Read` callback.
"""
function set_buffer_config(device::BrickletRS485, send_buffer_size, receive_buffer_size)
    device.deviceInternal.set_buffer_config(send_buffer_size, receive_buffer_size)
end

export get_buffer_config
"""
    $(SIGNATURES)

Returns the buffer configuration as set by :func:`Set Buffer Config`.
"""
function get_buffer_config(device::BrickletRS485)
    return device.deviceInternal.get_buffer_config()
end

export get_buffer_status
"""
    $(SIGNATURES)

Returns the currently used bytes for the send and received buffer.

See :func:`Set Buffer Config` for buffer size configuration.
"""
function get_buffer_status(device::BrickletRS485)
    return device.deviceInternal.get_buffer_status()
end

export enable_error_count_callback
"""
    $(SIGNATURES)

Enables the :cb:`Error Count` callback.

By default the callback is disabled.
"""
function enable_error_count_callback(device::BrickletRS485)
    device.deviceInternal.enable_error_count_callback()
end

export disable_error_count_callback
"""
    $(SIGNATURES)

Disables the :cb:`Error Count` callback.

By default the callback is disabled.
"""
function disable_error_count_callback(device::BrickletRS485)
    device.deviceInternal.disable_error_count_callback()
end

export is_error_count_callback_enabled
"""
    $(SIGNATURES)

Returns *true* if the :cb:`Error Count` callback is enabled,
*false* otherwise.
"""
function is_error_count_callback_enabled(device::BrickletRS485)
    return device.deviceInternal.is_error_count_callback_enabled()
end

export get_error_count
"""
    $(SIGNATURES)

Returns the current number of overrun and parity errors.
"""
function get_error_count(device::BrickletRS485)
    return device.deviceInternal.get_error_count()
end

export get_modbus_common_error_count
"""
    $(SIGNATURES)

Returns the current number of errors occurred in Modbus mode.

* Timeout Error Count: Number of timeouts occurred.
* Checksum Error Count: Number of failures due to Modbus frame CRC16 checksum mismatch.
* Frame Too Big Error Count: Number of times frames were rejected because they exceeded maximum Modbus frame size which is 256 bytes.
* Illegal Function Error Count: Number of errors when an unimplemented or illegal function is requested. This corresponds to Modbus exception code 1.
* Illegal Data Address Error Count: Number of errors due to invalid data address. This corresponds to Modbus exception code 2.
* Illegal Data Value Error Count: Number of errors due to invalid data value. This corresponds to Modbus exception code 3.
* Slave Device Failure Error Count: Number of errors occurred on the slave device which were unrecoverable. This corresponds to Modbus exception code 4.
"""
function get_modbus_common_error_count(device::BrickletRS485)
    return device.deviceInternal.get_modbus_common_error_count()
end

export modbus_slave_report_exception
"""
    $(SIGNATURES)

In Modbus slave mode this function can be used to report a Modbus exception for
a Modbus master request.

* Request ID: Request ID of the request received by the slave.
* Exception Code: Modbus exception code to report to the Modbus master.
"""
function modbus_slave_report_exception(device::BrickletRS485, request_id, exception_code)
    device.deviceInternal.modbus_slave_report_exception(request_id, exception_code)
end

export modbus_slave_answer_read_coils_request_low_level
"""
    $(SIGNATURES)

In Modbus slave mode this function can be used to answer a master request to
read coils.

* Request ID: Request ID of the corresponding request that is being answered.
* Coils: Data that is to be sent to the Modbus master for the corresponding request.

This function must be called from the :cb:`Modbus Slave Read Coils Request` callback
with the Request ID as provided by the argument of the callback.
"""
function modbus_slave_answer_read_coils_request_low_level(device::BrickletRS485, request_id, coils_length, coils_chunk_offset, coils_chunk_data)
    device.deviceInternal.modbus_slave_answer_read_coils_request_low_level(request_id, coils_length, coils_chunk_offset, coils_chunk_data)
end

export modbus_master_read_coils
"""
    $(SIGNATURES)

In Modbus master mode this function can be used to read coils from a slave. This
function creates a Modbus function code 1 request.

* Slave Address: Address of the target Modbus slave.
* Starting Address: Number of the first coil to read. For backwards compatibility reasons this parameter is called Starting Address. It is not an address, but instead a coil number in the range of 1 to 65536.
* Count: Number of coils to read.

Upon success the function will return a non-zero request ID which will represent
the current request initiated by the Modbus master. In case of failure the returned
request ID will be 0.

When successful this function will also invoke the :cb:`Modbus Master Read Coils Response`
callback. In this callback the Request ID provided by the callback argument must be
matched with the Request ID returned from this function to verify that the callback
is indeed for a particular request.
"""
function modbus_master_read_coils(device::BrickletRS485, slave_address, starting_address, count)
    return device.deviceInternal.modbus_master_read_coils(slave_address, starting_address, count)
end

export modbus_slave_answer_read_holding_registers_request_low_level
"""
    $(SIGNATURES)

In Modbus slave mode this function can be used to answer a master request to
read holding registers.

* Request ID: Request ID of the corresponding request that is being answered.
* Holding Registers: Data that is to be sent to the Modbus master for the corresponding request.

This function must be called from the :cb:`Modbus Slave Read Holding Registers Request`
callback with the Request ID as provided by the argument of the callback.
"""
function modbus_slave_answer_read_holding_registers_request_low_level(device::BrickletRS485, request_id, holding_registers_length, holding_registers_chunk_offset, holding_registers_chunk_data)
    device.deviceInternal.modbus_slave_answer_read_holding_registers_request_low_level(request_id, holding_registers_length, holding_registers_chunk_offset, holding_registers_chunk_data)
end

export modbus_master_read_holding_registers
"""
    $(SIGNATURES)

In Modbus master mode this function can be used to read holding registers from a slave.
This function creates a Modbus function code 3 request.

* Slave Address: Address of the target Modbus slave.
* Starting Address: Number of the first holding register to read. For backwards compatibility reasons this parameter is called Starting Address. It is not an address, but instead a holding register number in the range of 1 to 65536. The prefix digit 4 (for holding register) is implicit and must be omitted.
* Count: Number of holding registers to read.

Upon success the function will return a non-zero request ID which will represent
the current request initiated by the Modbus master. In case of failure the returned
request ID will be 0.

When successful this function will also invoke the :cb:`Modbus Master Read Holding Registers Response`
callback. In this callback the Request ID provided by the callback argument must be matched
with the Request ID returned from this function to verify that the callback is indeed for a
particular request.
"""
function modbus_master_read_holding_registers(device::BrickletRS485, slave_address, starting_address, count)
    return device.deviceInternal.modbus_master_read_holding_registers(slave_address, starting_address, count)
end

export modbus_slave_answer_write_single_coil_request
"""
    $(SIGNATURES)

In Modbus slave mode this function can be used to answer a master request to
write a single coil.

* Request ID: Request ID of the corresponding request that is being answered.

This function must be called from the :cb:`Modbus Slave Write Single Coil Request`
callback with the Request ID as provided by the arguments of the callback.
"""
function modbus_slave_answer_write_single_coil_request(device::BrickletRS485, request_id)
    device.deviceInternal.modbus_slave_answer_write_single_coil_request(request_id)
end

export modbus_master_write_single_coil
"""
    $(SIGNATURES)

In Modbus master mode this function can be used to write a single coil of a slave.
This function creates a Modbus function code 5 request.

* Slave Address: Address of the target Modbus slave.
* Coil Address: Number of the coil to be written. For backwards compatibility reasons, this parameter is called Starting Address. It is not an address, but instead a coil number in the range of 1 to 65536.
* Coil Value: Value to be written.

Upon success the function will return a non-zero request ID which will represent
the current request initiated by the Modbus master. In case of failure the returned
request ID will be 0.

When successful this function will also invoke the :cb:`Modbus Master Write Single Coil Response`
callback. In this callback the Request ID provided by the callback argument must be matched
with the Request ID returned from this function to verify that the callback is indeed for a
particular request.
"""
function modbus_master_write_single_coil(device::BrickletRS485, slave_address, coil_address, coil_value)
    return device.deviceInternal.modbus_master_write_single_coil(slave_address, coil_address, coil_value)
end

export modbus_slave_answer_write_single_register_request
"""
    $(SIGNATURES)

In Modbus slave mode this function can be used to answer a master request to
write a single register.

* Request ID: Request ID of the corresponding request that is being answered.

This function must be called from the :cb:`Modbus Slave Write Single Register Request`
callback with the Request ID, Register Address and Register Value as provided by
the arguments of the callback.
"""
function modbus_slave_answer_write_single_register_request(device::BrickletRS485, request_id)
    device.deviceInternal.modbus_slave_answer_write_single_register_request(request_id)
end

export modbus_master_write_single_register
"""
    $(SIGNATURES)

In Modbus master mode this function can be used to write a single holding register of a
slave. This function creates a Modbus function code 6 request.

* Slave Address: Address of the target Modbus slave.
* Register Address: Number of the holding register to be written. For backwards compatibility reasons, this parameter is called Starting Address. It is not an address, but instead a holding register number in the range of 1 to 65536. The prefix digit 4 (for holding register) is implicit and must be omitted.
* Register Value: Value to be written.

Upon success the function will return a non-zero request ID which will represent
the current request initiated by the Modbus master. In case of failure the returned
request ID will be 0.

When successful this function will also invoke the :cb:`Modbus Master Write Single Register Response`
callback. In this callback the Request ID provided by the callback argument must be matched
with the Request ID returned from this function to verify that the callback is indeed for a
particular request.
"""
function modbus_master_write_single_register(device::BrickletRS485, slave_address, register_address, register_value)
    return device.deviceInternal.modbus_master_write_single_register(slave_address, register_address, register_value)
end

export modbus_slave_answer_write_multiple_coils_request
"""
    $(SIGNATURES)

In Modbus slave mode this function can be used to answer a master request to
write multiple coils.

* Request ID: Request ID of the corresponding request that is being answered.

This function must be called from the :cb:`Modbus Slave Write Multiple Coils Request`
callback with the Request ID of the callback.
"""
function modbus_slave_answer_write_multiple_coils_request(device::BrickletRS485, request_id)
    device.deviceInternal.modbus_slave_answer_write_multiple_coils_request(request_id)
end

export modbus_master_write_multiple_coils_low_level
"""
    $(SIGNATURES)

In Modbus master mode this function can be used to write multiple coils of a slave.
This function creates a Modbus function code 15 request.

* Slave Address: Address of the target Modbus slave.
* Starting Address: Number of the first coil to write. For backwards compatibility reasons, this parameter is called Starting Address.It is not an address, but instead a coil number in the range of 1 to 65536.

Upon success the function will return a non-zero request ID which will represent
the current request initiated by the Modbus master. In case of failure the returned
request ID will be 0.

When successful this function will also invoke the :cb:`Modbus Master Write Multiple Coils Response`
callback. In this callback the Request ID provided by the callback argument must be matched
with the Request ID returned from this function to verify that the callback is indeed for a
particular request.
"""
function modbus_master_write_multiple_coils_low_level(device::BrickletRS485, slave_address, starting_address, coils_length, coils_chunk_offset, coils_chunk_data)
    return device.deviceInternal.modbus_master_write_multiple_coils_low_level(slave_address, starting_address, coils_length, coils_chunk_offset, coils_chunk_data)
end

export modbus_slave_answer_write_multiple_registers_request
"""
    $(SIGNATURES)

In Modbus slave mode this function can be used to answer a master request to
write multiple registers.

* Request ID: Request ID of the corresponding request that is being answered.

This function must be called from the :cb:`Modbus Slave Write Multiple Registers Request`
callback with the Request ID of the callback.
"""
function modbus_slave_answer_write_multiple_registers_request(device::BrickletRS485, request_id)
    device.deviceInternal.modbus_slave_answer_write_multiple_registers_request(request_id)
end

export modbus_master_write_multiple_registers_low_level
"""
    $(SIGNATURES)

In Modbus master mode this function can be used to write multiple registers of a slave.
This function creates a Modbus function code 16 request.

* Slave Address: Address of the target Modbus slave.
* Starting Address: Number of the first holding register to write. For backwards compatibility reasons, this parameter is called Starting Address. It is not an address, but instead a holding register number in the range of 1 to 65536. The prefix digit 4 (for holding register) is implicit and must be omitted.

Upon success the function will return a non-zero request ID which will represent
the current request initiated by the Modbus master. In case of failure the returned
request ID will be 0.

When successful this function will also invoke the :cb:`Modbus Master Write Multiple Registers Response`
callback. In this callback the Request ID provided by the callback argument must be matched
with the Request ID returned from this function to verify that the callback is indeed for a
particular request.
"""
function modbus_master_write_multiple_registers_low_level(device::BrickletRS485, slave_address, starting_address, registers_length, registers_chunk_offset, registers_chunk_data)
    return device.deviceInternal.modbus_master_write_multiple_registers_low_level(slave_address, starting_address, registers_length, registers_chunk_offset, registers_chunk_data)
end

export modbus_slave_answer_read_discrete_inputs_request_low_level
"""
    $(SIGNATURES)

In Modbus slave mode this function can be used to answer a master request to
read discrete inputs.

* Request ID: Request ID of the corresponding request that is being answered.
* Discrete Inputs: Data that is to be sent to the Modbus master for the corresponding request.

This function must be called from the :cb:`Modbus Slave Read Discrete Inputs Request`
callback with the Request ID as provided by the argument of the callback.
"""
function modbus_slave_answer_read_discrete_inputs_request_low_level(device::BrickletRS485, request_id, discrete_inputs_length, discrete_inputs_chunk_offset, discrete_inputs_chunk_data)
    device.deviceInternal.modbus_slave_answer_read_discrete_inputs_request_low_level(request_id, discrete_inputs_length, discrete_inputs_chunk_offset, discrete_inputs_chunk_data)
end

export modbus_master_read_discrete_inputs
"""
    $(SIGNATURES)

In Modbus master mode this function can be used to read discrete inputs from a slave.
This function creates a Modbus function code 2 request.

* Slave Address: Address of the target Modbus slave.
* Starting Address: Number of the first discrete input to read. For backwards compatibility reasons, this parameter is called Starting Address. It is not an address, but instead a discrete input number in the range of 1 to 65536. The prefix digit 1 (for discrete input) is implicit and must be omitted.
* Count: Number of discrete inputs to read.

Upon success the function will return a non-zero request ID which will represent
the current request initiated by the Modbus master. In case of failure the returned
request ID will be 0.

When successful this function will also invoke the :cb:`Modbus Master Read Discrete Inputs Response`
callback. In this callback the Request ID provided by the callback argument must be matched
with the Request ID returned from this function to verify that the callback is indeed for a
particular request.
"""
function modbus_master_read_discrete_inputs(device::BrickletRS485, slave_address, starting_address, count)
    return device.deviceInternal.modbus_master_read_discrete_inputs(slave_address, starting_address, count)
end

export modbus_slave_answer_read_input_registers_request_low_level
"""
    $(SIGNATURES)

In Modbus slave mode this function can be used to answer a master request to
read input registers.

* Request ID: Request ID of the corresponding request that is being answered.
* Input Registers: Data that is to be sent to the Modbus master for the corresponding request.

This function must be called from the :cb:`Modbus Slave Read Input Registers Request` callback
with the Request ID as provided by the argument of the callback.
"""
function modbus_slave_answer_read_input_registers_request_low_level(device::BrickletRS485, request_id, input_registers_length, input_registers_chunk_offset, input_registers_chunk_data)
    device.deviceInternal.modbus_slave_answer_read_input_registers_request_low_level(request_id, input_registers_length, input_registers_chunk_offset, input_registers_chunk_data)
end

export modbus_master_read_input_registers
"""
    $(SIGNATURES)

In Modbus master mode this function can be used to read input registers from a slave.
This function creates a Modbus function code 4 request.

* Slave Address: Address of the target Modbus slave.
* Starting Address: Number of the first input register to read. For backwards compatibility reasons, this parameter is called Starting Address. It is not an address, but instead an input register number in the range of 1 to 65536. The prefix digit 3 (for input register) is implicit and must be omitted.
* Count: Number of input registers to read.

Upon success the function will return a non-zero request ID which will represent
the current request initiated by the Modbus master. In case of failure the returned
request ID will be 0.

When successful this function will also invoke the :cb:`Modbus Master Read Input Registers Response`
callback. In this callback the Request ID provided by the callback argument must be matched
with the Request ID returned from this function to verify that the callback is indeed for a
particular request.
"""
function modbus_master_read_input_registers(device::BrickletRS485, slave_address, starting_address, count)
    return device.deviceInternal.modbus_master_read_input_registers(slave_address, starting_address, count)
end

export set_frame_readable_callback_configuration
"""
    $(SIGNATURES)

Configures the :cb:`Frame Readable` callback. The frame size is the number of bytes, that have to be readable to trigger the callback.
A frame size of 0 disables the callback. A frame size greater than 0 enables the callback and disables the :cb:`Read` callback.

By default the callback is disabled.

.. versionadded:: 2.0.5\$nbsp;(Plugin)
"""
function set_frame_readable_callback_configuration(device::BrickletRS485, frame_size)
    device.deviceInternal.set_frame_readable_callback_configuration(frame_size)
end

export get_frame_readable_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by :func:`Set Frame Readable Callback Configuration`.

.. versionadded:: 2.0.5\$nbsp;(Plugin)
"""
function get_frame_readable_callback_configuration(device::BrickletRS485)
    return device.deviceInternal.get_frame_readable_callback_configuration()
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
function get_spitfp_error_count(device::BrickletRS485)
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
function set_bootloader_mode(device::BrickletRS485, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletRS485)
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
function set_write_firmware_pointer(device::BrickletRS485, pointer)
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
function write_firmware(device::BrickletRS485, data)
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
function set_status_led_config(device::BrickletRS485, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletRS485)
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
function get_chip_temperature(device::BrickletRS485)
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
function reset(device::BrickletRS485)
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
function write_uid(device::BrickletRS485, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletRS485)
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
function get_identity(device::BrickletRS485)
    return device.deviceInternal.get_identity()
end

export write
"""
Writes characters to the RS485 interface. The characters can be binary data,
ASCII or similar is not necessary.

The return value is the number of characters that were written.

See :func:`Set RS485 Configuration` for configuration possibilities
regarding baudrate, parity and so on.
"""
function write(device::BrickletRS485, message)

        message = convert(Vector{String}, message)

    if length(message) > 65535
        throw(TinkerforgeInvalidParameterError("Message can be at most 65535 items long"))
    end

    message_length = length(message)
    message_chunk_offset = 0

    if message_length == 0
        message_chunk_data = ['\0'] * 60
        ret = write_low_level(device, message_length, message_chunk_offset, message_chunk_data)
        message_written = ret
    else
        message_written = 0

        lock(device.stream_lock) do
            while message_chunk_offset < message_length
                message_chunk_data = create_chunk_data(message, message_chunk_offset, 60, '\0')
                ret = write_low_level(device, message_length, message_chunk_offset, message_chunk_data)
                message_written += ret

                if ret < 60
                    break # either last chunk or short write
                end

                message_chunk_offset += 60
            end
        end
    end

        return message_written
end

export read
"""
Returns up to *length* characters from receive buffer.

Instead of polling with this function, you can also use
callbacks. But note that this function will return available
data only when the read callback is disabled.
See :func:`Enable Read Callback` and :cb:`Read` callback.
"""
function read(device::BrickletRS485, length)

        length = UInt16(length)

    lock(device.stream_lock) do
        ret = read_low_level(device, length)
            message_length = ret.message_length
        message_out_of_sync = ret.message_chunk_offset != 0

        message_data = ret.message_chunk_data

        while !message_out_of_sync && length(message_data) < message_length
            ret = read_low_level(device, length)
                message_length = ret.message_length
            message_out_of_sync = ret.message_chunk_offset != length(message_data)
            message_data += ret.message_chunk_data
        end

        if message_out_of_sync # discard remaining stream to bring it back in-sync
            while ret.message_chunk_offset + 60 < message_length
                ret = read_low_level(device, length)
                    message_length = ret.message_length
            end

            throw(TinkerforgeStreamOutOfSyncError("Message stream is out-of-sync"))
        end
    end

        return message_data[:message_length]
end

export modbus_slave_answer_read_coils_request
"""
In Modbus slave mode this function can be used to answer a master request to
read coils.

* Request ID: Request ID of the corresponding request that is being answered.
* Coils: Data that is to be sent to the Modbus master for the corresponding request.

This function must be called from the :cb:`Modbus Slave Read Coils Request` callback
with the Request ID as provided by the argument of the callback.
"""
function modbus_slave_answer_read_coils_request(device::BrickletRS485, request_id, coils)

        request_id = UInt8(request_id)
    coils = convert(Vector{Bool}, coils)

    if length(coils) > 65535
        throw(TinkerforgeInvalidParameterError("Coils can be at most 65535 items long"))
    end

    coils_length = length(coils)
    coils_chunk_offset = 0

    if coils_length == 0
        coils_chunk_data = [False] * 472
        ret = modbus_slave_answer_read_coils_request_low_level(device, request_id, coils_length, coils_chunk_offset, coils_chunk_data)
    else
        lock(device.stream_lock) do
            while coils_chunk_offset < coils_length
                coils_chunk_data = create_chunk_data(coils, coils_chunk_offset, 472, False)
                ret = modbus_slave_answer_read_coils_request_low_level(device, request_id, coils_length, coils_chunk_offset, coils_chunk_data)
                coils_chunk_offset += 472
            end
        end
    end

        return ret
end

export modbus_slave_answer_read_holding_registers_request
"""
In Modbus slave mode this function can be used to answer a master request to
read holding registers.

* Request ID: Request ID of the corresponding request that is being answered.
* Holding Registers: Data that is to be sent to the Modbus master for the corresponding request.

This function must be called from the :cb:`Modbus Slave Read Holding Registers Request`
callback with the Request ID as provided by the argument of the callback.
"""
function modbus_slave_answer_read_holding_registers_request(device::BrickletRS485, request_id, holding_registers)

        request_id = UInt8(request_id)
    holding_registers = convert(Vector{UInt16}, holding_registers)

    if length(holding_registers) > 65535
        throw(TinkerforgeInvalidParameterError("Holding Registers can be at most 65535 items long"))
    end

    holding_registers_length = length(holding_registers)
    holding_registers_chunk_offset = 0

    if holding_registers_length == 0
        holding_registers_chunk_data = [0] * 29
        ret = modbus_slave_answer_read_holding_registers_request_low_level(device, request_id, holding_registers_length, holding_registers_chunk_offset, holding_registers_chunk_data)
    else
        lock(device.stream_lock) do
            while holding_registers_chunk_offset < holding_registers_length
                holding_registers_chunk_data = create_chunk_data(holding_registers, holding_registers_chunk_offset, 29, 0)
                ret = modbus_slave_answer_read_holding_registers_request_low_level(device, request_id, holding_registers_length, holding_registers_chunk_offset, holding_registers_chunk_data)
                holding_registers_chunk_offset += 29
            end
        end
    end

        return ret
end

export modbus_master_write_multiple_coils
"""
In Modbus master mode this function can be used to write multiple coils of a slave.
This function creates a Modbus function code 15 request.

* Slave Address: Address of the target Modbus slave.
* Starting Address: Number of the first coil to write. For backwards compatibility reasons, this parameter is called Starting Address.It is not an address, but instead a coil number in the range of 1 to 65536.

Upon success the function will return a non-zero request ID which will represent
the current request initiated by the Modbus master. In case of failure the returned
request ID will be 0.

When successful this function will also invoke the :cb:`Modbus Master Write Multiple Coils Response`
callback. In this callback the Request ID provided by the callback argument must be matched
with the Request ID returned from this function to verify that the callback is indeed for a
particular request.
"""
function modbus_master_write_multiple_coils(device::BrickletRS485, slave_address, starting_address, coils)

        slave_address = UInt8(slave_address)
    starting_address = UInt32(starting_address)
    coils = convert(Vector{Bool}, coils)

    if length(coils) > 65535
        throw(TinkerforgeInvalidParameterError("Coils can be at most 65535 items long"))
    end

    coils_length = length(coils)
    coils_chunk_offset = 0

    if coils_length == 0
        coils_chunk_data = [False] * 440
        ret = modbus_master_write_multiple_coils_low_level(device, slave_address, starting_address, coils_length, coils_chunk_offset, coils_chunk_data)
    else
        lock(device.stream_lock) do
            while coils_chunk_offset < coils_length
                coils_chunk_data = create_chunk_data(coils, coils_chunk_offset, 440, False)
                ret = modbus_master_write_multiple_coils_low_level(device, slave_address, starting_address, coils_length, coils_chunk_offset, coils_chunk_data)
                coils_chunk_offset += 440
            end
        end
    end

        return ret
end

export modbus_master_write_multiple_registers
"""
In Modbus master mode this function can be used to write multiple registers of a slave.
This function creates a Modbus function code 16 request.

* Slave Address: Address of the target Modbus slave.
* Starting Address: Number of the first holding register to write. For backwards compatibility reasons, this parameter is called Starting Address. It is not an address, but instead a holding register number in the range of 1 to 65536. The prefix digit 4 (for holding register) is implicit and must be omitted.

Upon success the function will return a non-zero request ID which will represent
the current request initiated by the Modbus master. In case of failure the returned
request ID will be 0.

When successful this function will also invoke the :cb:`Modbus Master Write Multiple Registers Response`
callback. In this callback the Request ID provided by the callback argument must be matched
with the Request ID returned from this function to verify that the callback is indeed for a
particular request.
"""
function modbus_master_write_multiple_registers(device::BrickletRS485, slave_address, starting_address, registers)

        slave_address = UInt8(slave_address)
    starting_address = UInt32(starting_address)
    registers = convert(Vector{UInt16}, registers)

    if length(registers) > 65535
        throw(TinkerforgeInvalidParameterError("Registers can be at most 65535 items long"))
    end

    registers_length = length(registers)
    registers_chunk_offset = 0

    if registers_length == 0
        registers_chunk_data = [0] * 27
        ret = modbus_master_write_multiple_registers_low_level(device, slave_address, starting_address, registers_length, registers_chunk_offset, registers_chunk_data)
    else
        lock(device.stream_lock) do
            while registers_chunk_offset < registers_length
                registers_chunk_data = create_chunk_data(registers, registers_chunk_offset, 27, 0)
                ret = modbus_master_write_multiple_registers_low_level(device, slave_address, starting_address, registers_length, registers_chunk_offset, registers_chunk_data)
                registers_chunk_offset += 27
            end
        end
    end

        return ret
end

export modbus_slave_answer_read_discrete_inputs_request
"""
In Modbus slave mode this function can be used to answer a master request to
read discrete inputs.

* Request ID: Request ID of the corresponding request that is being answered.
* Discrete Inputs: Data that is to be sent to the Modbus master for the corresponding request.

This function must be called from the :cb:`Modbus Slave Read Discrete Inputs Request`
callback with the Request ID as provided by the argument of the callback.
"""
function modbus_slave_answer_read_discrete_inputs_request(device::BrickletRS485, request_id, discrete_inputs)

        request_id = UInt8(request_id)
    discrete_inputs = convert(Vector{Bool}, discrete_inputs)

    if length(discrete_inputs) > 65535
        throw(TinkerforgeInvalidParameterError("Discrete Inputs can be at most 65535 items long"))
    end

    discrete_inputs_length = length(discrete_inputs)
    discrete_inputs_chunk_offset = 0

    if discrete_inputs_length == 0
        discrete_inputs_chunk_data = [False] * 472
        ret = modbus_slave_answer_read_discrete_inputs_request_low_level(device, request_id, discrete_inputs_length, discrete_inputs_chunk_offset, discrete_inputs_chunk_data)
    else
        lock(device.stream_lock) do
            while discrete_inputs_chunk_offset < discrete_inputs_length
                discrete_inputs_chunk_data = create_chunk_data(discrete_inputs, discrete_inputs_chunk_offset, 472, False)
                ret = modbus_slave_answer_read_discrete_inputs_request_low_level(device, request_id, discrete_inputs_length, discrete_inputs_chunk_offset, discrete_inputs_chunk_data)
                discrete_inputs_chunk_offset += 472
            end
        end
    end

        return ret
end

export modbus_slave_answer_read_input_registers_request
"""
In Modbus slave mode this function can be used to answer a master request to
read input registers.

* Request ID: Request ID of the corresponding request that is being answered.
* Input Registers: Data that is to be sent to the Modbus master for the corresponding request.

This function must be called from the :cb:`Modbus Slave Read Input Registers Request` callback
with the Request ID as provided by the argument of the callback.
"""
function modbus_slave_answer_read_input_registers_request(device::BrickletRS485, request_id, input_registers)

        request_id = UInt8(request_id)
    input_registers = convert(Vector{UInt16}, input_registers)

    if length(input_registers) > 65535
        throw(TinkerforgeInvalidParameterError("Input Registers can be at most 65535 items long"))
    end

    input_registers_length = length(input_registers)
    input_registers_chunk_offset = 0

    if input_registers_length == 0
        input_registers_chunk_data = [0] * 29
        ret = modbus_slave_answer_read_input_registers_request_low_level(device, request_id, input_registers_length, input_registers_chunk_offset, input_registers_chunk_data)
    else
        lock(device.stream_lock) do
            while input_registers_chunk_offset < input_registers_length
                input_registers_chunk_data = create_chunk_data(input_registers, input_registers_chunk_offset, 29, 0)
                ret = modbus_slave_answer_read_input_registers_request_low_level(device, request_id, input_registers_length, input_registers_chunk_offset, input_registers_chunk_data)
                input_registers_chunk_offset += 29
            end
        end
    end

        return ret
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletRS485, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
