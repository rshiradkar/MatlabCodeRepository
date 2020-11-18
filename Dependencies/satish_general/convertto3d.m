function embedin3d = convertto3d(embed)
%function embedin3d = convertto3d(embed)

embed = squareform(pdist(embed));
embedin3d = mds(embed,3);

end