module List.Msg exposing (..)

type Msg a = Index Int a

inc : Msg a -> Msg a
inc (Index ix a) = Index (ix + 1) a