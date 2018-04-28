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
            return user.avatar?.style.backgroundColor
        }else{
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
        
        let y: Color?

        if let value = user.avatar {
            y =  value.style.backgroundColor
        } else{
            y = nil
        }

        
        if let value = y{
            return y
        }else{
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
        let y: Color?

        switch user.avatar{
            case .some(let value):
                y = value.style.backgroundColor
            case .none:
                y = nil
        }

        
        switch y{
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
        let y: Color?

        switch user.avatar{
            case .some(let value):
                y = value.style.backgroundColor
            case .none:
                y = nil
        }

        
        switch y{
            case .some(let z):
                return .some(z)

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
        let y: Optional<Color>

        switch user.avatar{
            case .some(let value):
                y = value.style.backgroundColor
            case .none:
                y = Optional.none
        }

        
        switch y{
            case .some(let z):
                return  .some(z)

            case .none:
                return  appTheme.backgroundColor
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
        let y: FakeOptional<Color>

        switch user.avatar{
            case .some(let value):
                y = value.style.backgroundColor.fakeOptional
            case .none:
                y = FakeOptional.none
        }

        
        switch y{
            case .some(let z):
                return  .some(z)

            case .none:
                return  appTheme.backgroundColor.fakeOptional
        }
    }
}


// Support for "fill in the blank" types
typealias ________ = Never
