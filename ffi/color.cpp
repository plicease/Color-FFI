using namespace std;

class Color {

public:
  Color(int, int, int);
  ~Color();
  
  int get_red() { return _red; }
  int get_green() { return _green; }
  int get_blue() { return _blue; }
  
  void set_red(int);
  void set_green(int);
  void set_blue(int);

  static Color *red()   { return new Color(255,0,0); }
  static Color *green() { return new Color(0,255,0); }
  static Color *blue()  { return new Color(0,0,255); }
  static Color *white() { return new Color(0xff,0xff,0xff); }
  static Color *black() { return new Color(0x00,0x00,0x00); }

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

extern "C" {

  extern void *c_new(int r, int g, int b)
  {
    Color *c = new Color(r,g,b);
    return (void *) c;
  }

  extern void c_DESTROY(void *c)
  {
    delete (Color*)c;
  }

};
