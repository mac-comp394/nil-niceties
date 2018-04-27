// FakeOptional
enum FakeOptional<Wrapped> {
    case some(Wrapped)
    case none
}

extension FakeOptional {
    var realOptional: Wrapped? {
        switch self {
            case .some(let value):
                return value
            case .none:
                return nil
        }
    }
}

extension Optional {
    var fakeOptional: FakeOptional<Wrapped> {
        if let value = self {
            return .some(value)
        } else {
            return .none
        }
    }
}






// Model
struct User {
    var name: String
    var avatar: StyledImage?
}

struct StyledImage {
    var image: Image
    var style: Style
}

struct Style {
    var backgroundColor: Color?
    var foregroundColor: Color?
}

struct Image {
    // pretend this contains real image data
}

enum Color {  // just the important ones
    case fuchsia
    case chartreuse
    case mauve
    case wenge
    case puce
    case smaragdine
    case fulvous
}





// ProfileScreen
class ProfileScreen {
    var user: User
    var appTheme: Style

    init(user: User, appTheme: Style) {
        self.user = user
        self.appTheme = appTheme
    }

    /**
        Returns the results of the all the various desugaring stages of headerBackgroundColor.
        The tests will check these to make sure they all match the correct value.

        Uncomment them one by one as you implement the desugaring.
    */
    var headerBackgroundColorDesugarings: [Color?] {
        return [
            headerBackgroundColor,
            headerBackgroundColor_desugaring_1,
            headerBackgroundColor_desugaring_2,
            headerBackgroundColor_desugaring_3,
            headerBackgroundColor_desugaring_4,
            headerBackgroundColor_desugaring_5,
            headerBackgroundColor_desugaring_verification.realOptional  // convert from FakeOptional; DO NOT MODIFY this line (except for uncommenting)
        ]
    }

    /**
        The original method, with all the sugar: returns the user’s avatar’s style’s background
        color if it exists; otherwise returns the appTheme’s default background color.
    */
    var headerBackgroundColor: Color? {
        return user.avatar?.style.backgroundColor ?? appTheme.backgroundColor
    }

    /**
        Swift’s ??, the “nil-coalescing” operator, takes an optional left-hand side (LHS). It returns the
        LHS if it is not optional, and the RHS if it is. In other words, this:

            let x = a ?? b

        ...is sugar for this:

            let x: T
            if let value = a {
                x = a
            } else {
                x = b
            }

        Copy the previous method here, and remove the nil coalescing.

        (Remember to uncomment the corresponding line in the headerBackgroundColorDesugarings array above
        before running the tests.)
    */
    var headerBackgroundColor_desugaring_1: Color? {
        if let value = user.avatar?.style.backgroundColor{
            return value
        } else {
            return appTheme.backgroundColor
        }
    }

    /**
        Swift’s ?. operator, “optional chaining,” makes a property accesses evaluate to nil if the LHS is
        nil, and otherwise continues following the property chain. In other words, this:

            let x = a?.b

        ...is sugar for this:

            let x: T?
            if let value = a {
                x = a.b
            } else {
                x = nil
            }

        Note that the ?. operator does not just affect its own node in the AST; it short-circuits an
        entire _chain_ of property accesses. In other words, this:

            let x = a?.b.c.d.e.f.g

        ...is sugar for this:

            let x: T?
            if let value = a {
                x = a.b.c.d.e.f.g
            } else {
                x = nil
            }

        Copy the previous method here, and remove all the optional chaining.
    */
    var headerBackgroundColor_desugaring_2: Color? {
        let bgColor: Color?
        if let avatar = user.avatar{
            bgColor = avatar.style.backgroundColor
        } else {
            bgColor = nil
        }

        if let value = bgColor{
            return value
        } else {
            return appTheme.backgroundColor
        }
    }

    /**
        Swift’s “if let” syntax, “optional binding,” is itself sugar for a case statement that matches
        the two possible values of the algebraic type Optional, some and none. In other words, this:

            if let b = a {
                doSomething(b)
            } else {
                doSomethingElse()
            }

        ...is sugar for this:

            switch a {
                case .some(let b):
                    doSomething(b)

                case .none:
                    doSomethingElse()
            }

        Copy the previous implementation here, and remove all the optional binding.

        (You’re remembering to uncomment the corresponding lines in the array up at the top of
        the file, right?)
    */
    var headerBackgroundColor_desugaring_3: Color? {
        let bgColor: Color?
        switch user.avatar{
            case .some(let avatar):
                bgColor = avatar.style.backgroundColor
            case .none:
                bgColor = nil
        }

        switch bgColor{
            case .some(let value):
                return value
            case .none:
                return appTheme.backgroundColor
        }
    }

    /**
        If you use an expression x of type T in a context that expects T?, you do not need to
        explicitly wrap x in Optional.some(...); Swift will do it for you.

        This bit of sugar is hard to spot, but it is still sugar, and it is specific to optionals.
        With any other enum, you would need to explicitly wrap the result, but for Optional, Swift
        will magically add .some(...) for you if necessary. In other words, this:

            let x: T = ...
            let y: T? = x

        ...is sugar for this:

            let x: T = ...
            let y: T? = .some(x)

        Copy the previous method here and remove Swift’s automatic Optional wrapping.
    */
    var headerBackgroundColor_desugaring_4: Color? {
        let bgColor: Color?
        switch user.avatar{
            case .some(let avatar):
                bgColor = avatar.style.backgroundColor
            case .none:
                bgColor = nil
        }

        switch bgColor{
            case .some(let value):
                return .some(value)
            case .none:
                return appTheme.backgroundColor
        }
    }

    /**
        The type syntax T? is sugar for Optional<T>. Desugar any types that use the T? syntax.

        Also, in Swift, nil is sugar for Optional.none. Your method might not actually
        use nil at all, but if it does, replace it with .none instead. (You can say .none instead
        of Optional.none if Swift can already infer that it’s an Optional from context.)
    */
    var headerBackgroundColor_desugaring_5: Optional<Color> {
        let bgColor: Optional<Color>
        switch user.avatar{
            case .some(let avatar):
                bgColor = avatar.style.backgroundColor
            case .none:
                bgColor = nil
        }

        switch bgColor{
            case .some(let value):
                return .some(value)
            case .none:
                return appTheme.backgroundColor
        }
    }

    /**
        Finally, a sanity check. This project declares an enum type named FakeOptional which has
        exactly the same structure as Swift’s Optional, but is a separate, unrelated type.

        Because it is different, Swift will not let you use any Optional sugar with FakeOptional.
        You can use this to verify your desugaring: replace Optional → FakeOptional in your method.

        Here's how:

        - Anywhere you use the type name Optional, replace it with FakeOptional.
        - Anywhere you use the two model properties that return Optional, convert them to FakeOptional instead:
            - Replace .avatar → .avatar.fakeOptional
            - Replace .backgroundColor → .backgroundColor.fakeOptional

        After doing this, your code should still compile. Uncomment the last line of
        headerBackgroundColorDesugarings up above (which converts your FakeOptional return value
        back to a real Optional), and the tests should still pass.
    */
    var headerBackgroundColor_desugaring_verification: FakeOptional<Color> {
        let bgColor: FakeOptional<Color>
        switch user.avatar{
            case .some(let avatar):
                bgColor = avatar.style.backgroundColor.fakeOptional
            case .none:
                bgColor = .none
        }

        switch bgColor{
            case .some(let value):
                return .some(value)
            case .none:
                return appTheme.backgroundColor.fakeOptional
        }
    }
}


// Support for "fill in the blank" types
typealias ________ = Never







// Testing

class OptionalDesugaringTests {
    let theme0 = Style(
        backgroundColor: nil,
        foregroundColor: .fulvous)

    let theme1 = Style(
        backgroundColor: .fuchsia,
        foregroundColor: .smaragdine)

    let theme2 = Style(
        backgroundColor: .mauve,
        foregroundColor: .wenge)

    func profileScreen(avatarStyle: Style?, appTheme: Style) -> ProfileScreen {
        let avatar: StyledImage?
        if let avatarStyle = avatarStyle {
            avatar = StyledImage(image: Image(), style: avatarStyle)
        } else {
            avatar = nil
        }
        return ProfileScreen(
            user: User(name: "Sally Jones", avatar: avatar),
            appTheme: appTheme)
    }


    func testAvatarHasBackgroundColor() {
        assertBackgroundColorDesugarings(
            on: profileScreen(avatarStyle: theme2, appTheme: theme1),
            allEqual: Color.mauve)
    }

    func testAvatarHasNoBackgroundColor() {
        assertBackgroundColorDesugarings(
            on: profileScreen(avatarStyle: theme0, appTheme: theme1),
            allEqual: Color.fuchsia)
    }

    func testAvatarAndAppThemeBothHaveNoBackgroundColor() {
        assertBackgroundColorDesugarings(
            on: profileScreen(avatarStyle: theme0, appTheme: theme0),
            allEqual: nil)
    }

    func testNoAvatar() {
        assertBackgroundColorDesugarings(
            on: profileScreen(avatarStyle: nil, appTheme: theme2),
            allEqual: Color.mauve)
    }

    func testNoStylesAtAll() {
        assertBackgroundColorDesugarings(
            on: profileScreen(avatarStyle: nil, appTheme: theme0),
            allEqual: nil)
    }

    func testAllDesugaringsImplemented() {
        XCTAssertEqual_I(
            profileScreen(avatarStyle: nil, appTheme: theme2).headerBackgroundColorDesugarings.count,
            7,
            "Not all desugarings are implemented yet")
    }

    private func assertBackgroundColorDesugarings(
            on profileScreen: ProfileScreen,
            allEqual expectedValue: Color?)
        {
        for (index, value) in profileScreen.headerBackgroundColorDesugarings.enumerated() {
            XCTAssertEqual_C(expectedValue, value, "Value \(index) does not match")
        }
    }

    private func XCTAssertEqual_C(_ expectedValue: Color?, _ value: Color?, _ message: String){
        if expectedValue != value{
            print(message)
        }
    }

    private func XCTAssertEqual_I(_ expectedValue: Int, _ value: Int, _ message: String){
        if expectedValue != value{
            print(message)
        }
    }
}

let test = OptionalDesugaringTests()
test.testAvatarHasBackgroundColor()
test.testAvatarHasNoBackgroundColor()
test.testAvatarAndAppThemeBothHaveNoBackgroundColor()
test.testNoAvatar()
test.testNoStylesAtAll()
test.testAllDesugaringsImplemented()
