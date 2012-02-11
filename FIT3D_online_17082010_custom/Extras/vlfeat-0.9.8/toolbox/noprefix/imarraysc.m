function varargout = imarraysc(varargin)
% VL_IMARRAYSC  Scale and flattens image array
%   J = VL_IMARRAYSC(A) behaves as VL_IMARRAY(A), but scales the range of
%   each image to span the current colormap.
%
%   VL_IMARRAYSC(...) displays the resulting image rather than
%   returing it.
%
%   VL_IMARRAYSC() works only with indexed (or gray-scale) images.
%
%   VL_IMARRAYSC() accepts the options of VL_IMARRAY() and:
%
%   CLim [[]]:: 
%     Specify the intensity range. If empty, the range is
%     calcualted automatically.
%
%   See also:: VL_IMARRAY(), VL_HELP().
[varargout{1:nargout}] = vl_imarraysc(varargin{:});
