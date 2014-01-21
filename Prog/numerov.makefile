########################

TARGET_scatt = numerov_scatt.x
TARGET_bound = numerov_bound.x

##########

-include objs_base_1.makefile

#-include objs_base_2.makefile

#-include objs_base_3.makefile

OBJS_base = $(OBJS_base_1) $(OBJS_base_2) $(OBJS_base_3)

##########

OBJS_scatt = $(OBJS_base) \
	numerov.o \
	main_numerov_scatt.o \

OBJS_bound = $(OBJS_base) \
	numerov.o \
	main_numerov_bound.o \

##########

-include objs_mods_base.makefile
-include objs_mods_fitter.makefile

OBJS_MODS = $(OBJS_MODS_base_1) \
	$(OBJS_MODS_base_2) \
	$(OBJS_MODS_fitter) \

##########

-include objs_lib.makefile

########################

all: $(TARGET_scatt) $(TARGET_bound)


$(TARGET_scatt): $(OBJS_scatt) $(OBJS_MODS) $(OBJS_LIB) $(OBJS_LIB_CRN_MNT)
	$(FC) -o $@ $(OBJS_scatt) $(OBJS_MODS) $(OBJS_LIB) $(OBJS_LIB_CRN_MNT) $(CRN_LIB) $(LAPACK_LIB)

$(TARGET_bound): $(OBJS_bound) $(OBJS_MODS) $(OBJS_LIB) $(OBJS_LIB_CRN_MNT)
	$(FC) -o $@ $(OBJS_bound) $(OBJS_MODS) $(OBJS_LIB) $(OBJS_LIB_CRN_MNT) $(CRN_LIB) $(LAPACK_LIB)


###
$(OBJS_scatt): $(OBJS_MODS)
$(OBJS_bound): $(OBJS_MODS)
#
$(OBJS_LIB0):
$(OBJS_LIB1): 
###

-include clean.makefile

##########

-include suffix.makefile

#################   EOF   #################
