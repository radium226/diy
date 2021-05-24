FIRMWARE_URL = https://micropython.org/resources/firmware/esp8266-20210418-v1.15.bin


SERIAL_PORT = /dev/ttyUSB0
BAUD = 115200

esp8266.bin:
	curl \
		"https://micropython.org/resources/firmware/esp8266-20210418-v1.15.bin" \
		-o "esp8266.bin"

.PHONY: clean
clean:
	rm -f "./esp8266.bin"

.PHONY: allow-serial-port
allow-serial-port:
	sudo chmod a+rw "$(SERIAL_PORT)"

.PHONY: erase-flash
erase-flash:
	esptool.py --port "$(SERIAL_PORT)" erase_flash

.PHONY: write-flash
write-flash: esp8266.bin erase-flash allow-serial-port
	echo "Press the flash button! "
	esptool.py \
		--port "$(SERIAL_PORT)" \
		--baud "$(BAUD)" \
		write_flash \
			--flash_size="detect" \
			-fm dio 0 \
			"./esp8266.bin"

.PHONY: run-python
run-python:
	echo "Press CTRL+A+X to exit! "
	picocom \
		--baud $(BAUD) \
		"$(SERIAL_PORT)" 

.PHONY: list-files
list-files:
	ampy \
		--port "$(SERIAL_PORT)" \
		--baud "$(BAUD)" \
		ls

.PHONY: put-file
put-file:
	ampy \
		--port "$(SERIAL_PORT)" \
		--baud "$(BAUD)" \
		put "$(FILE)"