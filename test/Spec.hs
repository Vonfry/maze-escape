-- |

module Main where

import Test.Hspec
import Game.Maze
import Game.Maze.Data

main :: IO ()
main = hspec $
  describe "Escape from maze" $ do
    it "Case 1" $
      runTestCase case1 `shouldBe` 2
    it "Case 2" $
      runTestCase case2 `shouldBe` 4
    it "Case 3" $
      runTestCase case3 `shouldBe` 4
    it "Case 4" $
      runTestCase case4 `shouldBe` 3

runTestCase :: MazeMap -> Int
runTestCase = length . shortestEscapePath

case1 = MazeMapList [[S]
                    ,[D]]

case2 = MazeMapList [[X, X, S]
                    ,[D, O, O]]

case3 = MazeMapList [[X, X, S]
                    ,[D, O, O]
                    ,[X, O, O]]

case4 = MazeMapList [[X, O, X]
                    ,[X, S, O]
                    ,[O, O, O]
                    ,[O, D, O]]
