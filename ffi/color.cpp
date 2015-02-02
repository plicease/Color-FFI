class Color {

public:
  Color(int, int, int);
  ~Color();

  int get_red();
  int get_green();
  int get_blue();

  void set_red(int);
  void set_green(int);
  void set_blue(int);

  static Color *red();
  static Color *green();
  static Color *blue();
  static Color *white();
  static Color *black();

  static int _sizeof();

private:
  int _red, _green, _blue;
};

Color::Color(int r, int g, int b) : _red(r), _green(g), _blue(b)
{
}

Color::~Color()
{
}

void Color::set_red(int r)
{
  _red = r;
}

void Color::set_green(int g)
{
  _green = g;
}

void Color::set_blue(int b)
{
  _blue = b;
}

int Color::get_red()   { return _red; }
int Color::get_green() { return _green; }
int Color::get_blue()  { return _blue; }

Color *Color::red()   { return new Color(255,0,0); }
Color *Color::green() { return new Color(0,255,0); }
Color *Color::blue()  { return new Color(0,0,255); }
Color *Color::white() { return new Color(0xff,0xff,0xff); }
Color *Color::black() { return new Color(0x00,0x00,0x00); }

int Color::_sizeof() { return sizeof(Color); }
