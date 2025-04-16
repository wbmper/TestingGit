#include <gtest/gtest.h>
#include <gmock/gmock.h>
#include "../module1/add.cpp"

TEST(AdditionTest, PositiveNumbers){
    EXPECT_EQ(add(2, 3), 5);
}

int main()
{
    ::testing::InitGoogleMock();
    return RUN_ALL_TESTS();
}

