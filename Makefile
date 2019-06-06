CXX ?= g++
CPPFLAGS ?= -O3 -Wall -Wextra -fPIC -std=c++17

COM_COLOR   = \033[0;34m
OBJ_COLOR   = \033[0;36m
OK_COLOR    = \033[1;32m
ERROR_COLOR = \033[1;31m
WARN_COLOR  = \033[1;33m
NO_COLOR    = \033[m

OK_STRING    = "[OK]"
ERROR_STRING = "[ERROR]"
WARN_STRING  = "[WARNING]"
COM_STRING   = "Compiling"

SRC_DIR    := src
HEADER_DIR := include
BIN_DIR    := bin
OBJ_DIR    := $(BIN_DIR)/obj
MAIN       := $(SRC_DIR)/main.cpp
SOURCES    := $(filter-out $(SRC_DIR)/main.cpp, $(wildcard $(SRC_DIR)/*.cpp))
OBJECTS    := $(SOURCES:$(SRC_DIR)/%.cpp=$(OBJ_DIR)/%.o)
EXECUTABLE := $(BIN_DIR)/SHA256

clean: COUNT=$(words $(wildcard $(OBJ_DIR)/*.o))

all: $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS) $(MAIN)
	@script -q -e -c '$(CXX) -I$(HEADER_DIR) -o $@ $(OBJECTS) $(MAIN)' $@.log > /dev/null; \
	RESULT=$$?; \
	sed -i '1d;$$d' $@.log; \
	sed -i '/^[[:space:]]*$$/d' $@.log; \
	if [ $$RESULT -ne 0 ]; then \
		printf "%-60b%b" "$(COM_COLOR)Building$(OBJ_COLOR) $@" "$(ERROR_COLOR)$(ERROR_STRING)$(NO_COLOR)\n"; \
	elif [ -s $@.log ]; then \
		printf "%-60b%b" "$(COM_COLOR)Building$(OBJ_COLOR) $@" "$(WARN_COLOR)$(WARN_STRING)$(NO_COLOR)\n"; \
	else  \
		printf "%-60b%b" "$(COM_COLOR)Building$(OBJ_COLOR) $@" "$(OK_COLOR)$(OK_STRING)$(NO_COLOR)\n"; \
		printf "%b" "$(OK_COLOR)Build success$(NO_COLOR)\n"; \
	fi; \
	cat $@.log; \
	rm -f $@.log; \

$(OBJECTS): $(OBJ_DIR)/%.o : $(SRC_DIR)/%.cpp
	@script -q -e -c '$(CXX) $(CPPFLAGS) -c -I$(HEADER_DIR) $< -o $@' $@.log > /dev/null; \
	RESULT=$$?; \
	sed -i '1d;$$d' $@.log; \
	sed -i '/^[[:space:]]*$$/d' $@.log; \
	if [ $$RESULT -ne 0 ]; then \
		printf "%-60b%b" "$(COM_COLOR)$(COM_STRING)$(OBJ_COLOR) $@" "$(ERROR_COLOR)$(ERROR_STRING)$(NO_COLOR)\n"; \
	elif [ -s $@.log ]; then \
		printf "%-60b%b" "$(COM_COLOR)$(COM_STRING)$(OBJ_COLOR) $@" "$(WARN_COLOR)$(WARN_STRING)$(NO_COLOR)\n"; \
	else  \
		printf "%-60b%b" "$(COM_COLOR)$(COM_STRING)$(OBJ_COLOR) $@" "$(OK_COLOR)$(OK_STRING)$(NO_COLOR)\n"; \
	fi; \
	cat $@.log; \
	rm -f $@.log; \

clean:
	@if [ $(COUNT) -ne 0 ] || [ -f  $(EXECUTABLE) ]; then \
	if [ $(COUNT) -ne 0 ]; then \
		printf "%b" "$(COM_COLOR)Cleaning objects$(NO_COLOR)\n"; \
		rm -f $(OBJ_DIR)/*.o; \
	fi; \
	if [ -f  $(EXECUTABLE) ]; then \
		printf "%b" "$(COM_COLOR)Removing executable$(NO_COLOR)\n"; \
		rm -f  $(EXECUTABLE); \
	fi; \
	printf "%b" "$(OK_COLOR)Clean complete$(NO_COLOR)\n"; \
	else \
	printf "%b" "$(OK_COLOR)Nothing to clean$(NO_COLOR)\n"; \
	fi;
