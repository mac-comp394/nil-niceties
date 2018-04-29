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
    case smaragdine // i like this one especially because it's me
    case fulvous
    
    // you forgot Taupe and Beige!
}
