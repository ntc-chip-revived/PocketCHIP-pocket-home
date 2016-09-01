export CONFIG:=Release

PKG_CONFIG:=$(shell which pkg-config)

PKG_CONFIG_PACKAGES = \
  NetworkManager \
  libnm-glib \
	alsa \

export PKG_CONFIG_CFLAGS=$(foreach pkg, $(PKG_CONFIG_PACKAGES), $(shell $(PKG_CONFIG) --cflags $(pkg)))
export PKG_CONFIG_LDFLAGS=$(foreach pkg, $(PKG_CONFIG_PACKAGES), $(shell $(PKG_CONFIG) --libs $(pkg)))



all:
	cd Builds/LinuxMakefile && \
	sed -i '2946s/(styleFlags & windowIsSemiTransparent) ? 32 : 24/32/' ../../deps/JUCE/modules/juce_gui_basics/native/juce_linux_Windowing.cpp && \
	$(MAKE)

clean:
	cd Builds/LinuxMakefile && $(MAKE) clean

wifitest:
	cd Builds/LinuxMakefile && $(MAKE) -f UnitTests.mk ../../build/$(CONFIG)/wifitest

devinstall:
	killall pocket-home ;\
	sudo cp build/$(CONFIG)/pocket-home /usr/bin/pocket-home && \
	sudo cp -R assets/* /usr/share/pocket-home
