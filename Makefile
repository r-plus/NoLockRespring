include theos/makefiles/common.mk

LIBRARY_NAME = Toggle
Toggle_FILES = NoLockRespring.m
Toggle_INSTALL_PATH = /var/mobile/Library/SBSettings/Toggles/NLR/
Toggle_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/library.mk
