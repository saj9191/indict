open Language;;

module type Indict_signature =
  functor (L: Language_signature) ->
    sig
      val indict_file: string -> unit
    end;;

module Indict : Indict_signature;;
