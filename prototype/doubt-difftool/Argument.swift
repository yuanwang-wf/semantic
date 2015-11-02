enum Argument {
	indirect case File(Source, Argument)
	indirect case OutputFlag(Output, Argument)
	case End

	var rest: Argument? {
		switch self {
		case let .File(_, rest):
			return rest
		case let .OutputFlag(_, rest):
			return rest
		case .End:
			return nil
		}
	}

	var files: [Source] {
		switch self {
		case let .File(a, rest):
			return [a] + rest.files
		default:
			return rest?.files ?? []
		}
	}

	enum Output {
		case Unified
		case Split
	}
}

private let flag: Madness.Parser<[String], Argument.Output>.Function =
		const(Argument.Output.Unified) <^> satisfy { $0 == "--unified" }
	<|> const(Argument.Output.Split) <^> satisfy { $0 == "--split" }

let argumentsParser: Madness.Parser<[String], Argument>.Function =
	curry(Argument.OutputFlag) <^> flag <*> pure(Argument.End)


import Madness
import Prelude
