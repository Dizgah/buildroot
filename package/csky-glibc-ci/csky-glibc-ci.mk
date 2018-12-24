##############################################################################
#
# glibc ci
#
################################################################################

CSKY_GLIBC_CI_VERSION = 9bb191429692cd8fb256703b0261a26e52535e24
CSKY_GLIBC_CI_SITE = $(call github,c-sky,csky-glibc-ci,$(CSKY_GLIBC_CI_VERSION))

CSKY_GLIBC_CI_DEPENDENCIES = openssh

define CSKY_GLIBC_CI_INSTALL_TARGET_CMDS
mkdir -p $(HOST_DIR)/csky-glibc-ci/
mkdir -p $(TARGET_DIR)/root/.ssh
cp -f $(@D)/csky-glibc-ci.sh $(HOST_DIR)/csky-glibc-ci/
cp -f $(@D)/make-check.sh $(HOST_DIR)/csky-glibc-ci/
cp -f ~/.ssh/id_rsa.pub  $(TARGET_DIR)/root/.ssh/authorized_keys
cp -f $(@D)/S50sshd $(TARGET_DIR)/etc/init.d/
rm output/build/glibc-*/build -rf
cd $(BUILD_DIR)/glibc-*/;tar -cJf $(BINARIES_DIR)/glibc.tar.xz ./;cd -
echo "Test glibc-ci"
endef

$(eval $(generic-package))