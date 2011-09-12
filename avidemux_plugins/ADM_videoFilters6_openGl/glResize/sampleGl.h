// Invert x & y
static const char *myShaderY =
	"#extension GL_ARB_texture_rectangle: enable\n"
	"uniform sampler2DRect myTextureY;\n" // tex unit 0
    "uniform sampler2DRect myTextureU;\n" // tex unit 1
    "uniform sampler2DRect myTextureV;\n" // tex unit 2
    "uniform float myWidth;\n"
    "uniform float myHeight;\n"
    "uniform float teta;\n"

	"void main(void) {\n"
    "  float mx = gl_TexCoord[0].x-myWidth/2;\n"
	"  float my = gl_TexCoord[0].y-myHeight/2;\n"
    "  float c=cos(teta); \n"
    "  float s=sin(teta); \n"
    "  float nx=mx*c-my*s;\n"
    "  float ny=mx*s+my*c;\n"
    "  vec4 texvalV = texture2DRect(myTextureV, vec2(nx/2+myWidth/4,ny/2+myHeight/4));\n"
    "  vec4 texvalU = texture2DRect(myTextureU, vec2(nx/2+myWidth/4,ny/2+myHeight/4));\n"
	"  vec4 texvalY = texture2DRect(myTextureY, vec2(nx+myWidth/2,ny+myHeight/2));\n"
	"  gl_FragColor = vec4(texvalY.r, texvalU.r, texvalV.r, 1.0);\n"
	"}\n";

