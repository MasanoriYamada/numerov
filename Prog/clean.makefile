########################

clean:
	rm -rf $(TARGET) ; \
	rm -rf *.o *.mod *.L i.* *.log *.il *.x ; \

allclean:
	rm -rf $(TARGET) ; \
	rm -rf *.o *.mod *.L i.* *.log *.il *.x ; \
	rm -rf ./minuit/code/*.o ; \
	rm -rf ./minuit/unix/*.o ; \
	rm -rf ./ffte/code/*.o ; \

##########
