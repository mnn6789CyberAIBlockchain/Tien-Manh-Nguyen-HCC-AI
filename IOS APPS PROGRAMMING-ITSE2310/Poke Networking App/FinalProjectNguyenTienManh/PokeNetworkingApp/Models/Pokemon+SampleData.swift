extension Pokemon {

    static var sample: Self {
        .init(
            name: "Sample-mon",
            height: 5,
            abilities: [
                AbilityWrapper(
                    ability: Ability(name: "sample ability 1"),
                    is_hidden: false,
                    slot: 0
                ),
                AbilityWrapper(
                    ability: Ability(name: "sample ability 2"),
                    is_hidden: false,
                    slot: 1
                ),
                AbilityWrapper(
                    ability: Ability(name: "sample ability 3"),
                    is_hidden: false,
                    slot: 2
                )
            ],
            moves: [
                MoveWrapper(move: Move(name: "sample move 1")),
                MoveWrapper(move: Move(name: "sample move 2")),
                MoveWrapper(move: Move(name: "sample move 3"))
            ],
            sprites: Sprites(
                front_default: "",
                back_default: ""
            )
        )
    }

}
