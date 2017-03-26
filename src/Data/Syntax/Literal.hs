{-# LANGUAGE DataKinds #-}
module Data.Syntax.Literal where

import Data.Syntax.Comment
import Data.Functor.Union
import Prologue


-- Numeric

-- | A literal integer of unspecified width. No particular base is implied.
newtype IntegerLiteral a = IntegerLiteral { integerLiteralContent :: ByteString }


-- Strings, symbols

newtype StringLiteral a = StringLiteral { stringElements :: [Union '[InterpolationElement, TextElement] a] } -- may also wish to include escapes
  deriving (Eq, Show)

-- | An interpolation element within a string literal.
newtype InterpolationElement a = InterpolationElement { interpolationBody :: a }
  deriving (Eq, Show)

-- | A sequence of textual contents within a string literal.
newtype TextElement a = TextElement { textElementContent :: ByteString }
  deriving (Eq, Show)


newtype SymbolLiteral a = SymbolLiteral { symbolLiteralContent :: ByteString }
  deriving (Eq, Show)


-- Collections

newtype ArrayLiteral a = ArrayLiteral { arrayLiteralElements :: [Union '[Identity, Comment] a] }
  deriving (Eq, Show)

newtype HashLiteral a = HashLiteral { hashLiteralElements :: [Union '[KeyValue, Comment] a] }
  deriving (Eq, Show)

data KeyValue a = KeyValue { key :: !a, value :: !a }
  deriving (Eq, Show)
