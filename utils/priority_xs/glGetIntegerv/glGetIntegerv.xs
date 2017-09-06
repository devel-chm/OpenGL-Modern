/*
 * This pattern uses the Template Toolkit to populate the
 * OpenGL bindings.  Need to implement the index variants
 * of the glGet routines---are there any special issues?
 *
 * GLtype         Name           newSVxv
 * ---------------------------------------
 * GLboolean      Boolean        newSViv
 * GLdouble       Double         newSVnv
 * GLfloat        Float          newSVnv
 * GLint          Integer        newSViv
 * GLint64        Integer64      newSViv
 */

void
glGet[% Name %]v_p(pname)
        GLenum  pname
        PPCODE:
        {
                [% GLtype %] data[MAX_GL_GET_COUNT];
                int n = gl_get_count(pname);
                int i;
                if (n > MAX_GL_GET_COUNT) {
                    // TODO: implement memory allocation
                    croak("Too many values for pname=%d", pname);
                }
                glGet[% Name %]v(pname, &data[0]);
                EXTEND(sp, n);
                for(i=0;i<n;i++)
                        PUSHs(sv_2mortal([% newSVxv %](data[i])));
        }


void
glGet[% Name %]i_v_p(target, index)
        GLenum  target
        GLuint  index
        PPCODE:
        {
                [% GLtype %] data[MAX_GL_GET_COUNT];
                int n = gl_get_count(target);
                int i;
                if (n > MAX_GL_GET_COUNT) {
                    // TODO: implement memory allocation
                    croak("Too many values for target=%d", target);
                }
                glGet[% Name %]i_v(target, index, &data[0]);
                EXTEND(sp, n);
                for(i=0;i<n;i++)
                        PUSHs(sv_2mortal([% newSVxv %](data[i])));
        }

