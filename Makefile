.PHONY: all module1 module2

all: module1 module2 main

module1:
	$(MAKE) -C module1

module2:
	$(MAKE) -C module2

main: main.cpp module1/add.o module2/sub.o
	g++ -std=c++98 -Wall main.cpp module1/add.o module2/sub.o -o main

# === 🔽 Google Test 기반 테스트 타겟 추가 ===

GTEST_DIR = external
GTEST_SRC = $(GTEST_DIR)/googletest/src/gtest-all.cc
GMOCK_SRC = $(GTEST_DIR)/googlemock/src/gmock-all.cc
GTEST_INC = -I$(GTEST_DIR)/googletest/include -I$(GTEST_DIR)/googlemock/include -I$(GTEST_DIR)/googletest -I$(GTEST_DIR)/googlemock

TEST_SRC = test/sample_test.cpp
TEST_TARGET = unit_tests

test: $(TEST_TARGET)

$(TEST_TARGET): $(TEST_SRC) $(GTEST_SRC) $(GMOCK_SRC)
	g++ -std=c++17 -Wall $(TEST_SRC) $(GTEST_SRC) $(GMOCK_SRC) $(GTEST_INC) -o $(TEST_TARGET) -pthread

clean:
	rm -f main $(TEST_TARGET)
	$(MAKE) -C module1 clean
	$(MAKE) -C module2 clean